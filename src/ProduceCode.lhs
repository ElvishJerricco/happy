-----------------------------------------------------------------------------
$Id: ProduceCode.lhs,v 1.32 2000/07/11 10:07:13 simonmar Exp $

The code generator.

(c) 1993-1996 Andy Gill, Simon Marlow
-----------------------------------------------------------------------------

> module ProduceCode (produceParser, str, interleave, interleave') where

> import Version		( version )
> import GenUtils
> import AbsSyn
> import Grammar
> import Target			( Target(..) )

> import Maybe 			( isJust )
> import Char
> import ST
> import IOExts
> import List

#if __GLASGOW_HASKELL__ > 408

> import MArray
> import IArray
> marray_indices a = MArray.indices a

#elif __GLASGOW_HASKELL__ == 408

> import MArray hiding (assocs, indices, elems)
> import IArray
> marray_indices a = MArray.indices a	-- add args to avoid MR :-(
> readArray  a ix   = get a ix
> writeArray a ix e = put a ix e
> newArray b  = marray b

#else

> import Array

> type STUArray s ix e = STArray s ix e
> type UArray ix e = Array ix e
> readArray  = readSTArray
> writeArray = writeSTArray
> freeze     = freezeSTArray
> marray_indices arr = range (boundsSTArray arr)

#endif

%-----------------------------------------------------------------------------
Produce the complete output file.

> produceParser :: Grammar 			-- grammar info
>		-> ActionTable 			-- action table
>		-> GotoTable 			-- goto table
>		-> Maybe (String,String)	-- lexer
>		-> [(Int,String)]		-- token reps
>		-> String			-- token type
>		-> String			-- parser name
>		-> (Maybe (String,String,String)) -- optional monad
>		-> String			-- stuff to go at the top
>		-> Maybe String			-- module header
>		-> Maybe String			-- module trailer
>		-> Target			-- type of code required
>		-> Bool				-- use coercions
>		-> Bool				-- use ghc extensions
>		-> String

> produceParser (Grammar 
>		{ productions = prods
>		, lookupProdNo = lookupProd
>		, lookupProdsOfName = lookupProdNos
>		, non_terminals = nonterms
>		, terminals = terms
>		, types = nt_types
>		, token_names = names
>		, eof_term = eof
>		, first_term = fst_term
>		})
>	 	action goto lexer token_rep token_type
>		name monad top_options module_header module_trailer 
>		target coerce ghc
>     =	( str top_options
>	. str comment
>	. maybestr module_header . nl
> 	. produceAbsSynDecl . nl
>    	. produceTypes
>	. produceActionTable target
>	. produceReductions
>	. produceTokenConverter . nl
>	. produceMonadStuff
>	. (if (not . null) name 
>		then (str name . str " = happyParse\n\n") 
>		else id)
>	. maybestr module_trailer
>	) ""
>   where

%-----------------------------------------------------------------------------
Make the abstract syntax type declaration, of the form:

data HappyAbsSyn a t1 .. tn
	= HappyTerminal a
	| HappyAbsSyn1 t1
	...
	| HappyAbsSynn tn

>    produceAbsSynDecl 

If we're using coercions, we need to generate the injections etc.

	data HappyAbsSyn ti tj tk ... = HappyAbsSyn

(where ti, tj, tk are type variables for the non-terminals which don't
 have type signatures).

	happyIn<n> :: ti -> HappyAbsSyn ti tj tk ...
	happyIn<n> x = unsafeCoerce# x
	{-# INLINE happyIn<n> #-}

	happyOut<n> :: HappyAbsSyn ti tj tk ... -> tn
	happyOut<n> x = unsafeCoerce# x
	{-# INLINE happyOut<n> #-}

>     | coerce 
>	= let
>	      happy_item = str "HappyAbsSyn " . str_tyvars
>	      bhappy_item = brack' happy_item
>
>	      inject n ty
>		= mkHappyIn n . str " :: " . type_param n ty
>		. str " -> " . bhappy_item . char '\n'
>		. mkHappyIn n . str " x = unsafeCoerce# x\n"
>		. str "{-# INLINE " . mkHappyIn n . str " #-}"
>
>	      extract n ty
>		= mkHappyOut n . str " :: " . bhappy_item
>		. str " -> " . type_param n ty . char '\n'
>		. mkHappyOut n . str " x = unsafeCoerce# x\n"
>		. str "{-# INLINE " . mkHappyOut n . str " #-}"
>	  in
>	    str "data " . happy_item . str " = HappyAbsSyn\n"
>	  . interleave "\n" 
>	    [ inject n ty . nl . extract n ty | (n,ty) <- assocs nt_types ]
>	  -- token injector
>	  . str "happyInTok :: " . str token_type . str " -> " . bhappy_item
>	  . str "\nhappyInTok x = unsafeCoerce# x\n{-# INLINE happyInTok #-}\n"
>	  -- token extractor
>	  . str "happyOutTok :: " . bhappy_item . str " -> " . str token_type
>	  . str "\nhappyOutTok x = unsafeCoerce# x\n{-# INLINE happyOutTok #-}\n"

Otherwise, output the declaration in full...

>     | otherwise
>	= str "data HappyAbsSyn " . str_tyvars
>	. str "\n\t= HappyTerminal " . str token_type
>	. str "\n\t| HappyErrorToken Int\n"
>	. interleave "\n" 
>         [ str "\t| " . makeAbsSynCon n . strspace . type_param n ty
>         | (n, ty) <- assocs nt_types, 
>	    (nt_types_index ! n) == n]

>     where all_tyvars = [ 't':show n | (n, Nothing) <- assocs nt_types ]
>	    str_tyvars = str (unwords all_tyvars)

%-----------------------------------------------------------------------------
Type declarations of the form:

type HappyReduction a b = ....
action_0, action_1 :: Int -> HappyReduction a b 
reduction_1, ...   :: HappyReduction a b 

These are only generated if types for *all* rules are given (and not for array
based parsers -- types aren't as important there).

>    produceTypes 
>     | target == TargetArrayBased = id

>     | all isJust (elems nt_types) =
>       str "type HappyReduction = \n\t"
>     . str "   "
>     . intMaybeHash
>     . str " \n\t-> " . token
>     . str "\n\t-> HappyState "
>     . token
>     . str " ([HappyAbsSyn] -> " . tokens . result
>     . str ")\n\t"
>     . str "-> [HappyState "
>     . token
>     . str " ([HappyAbsSyn] -> " . tokens . result
>     . str ")] \n\t-> [HappyAbsSyn] \n\t-> "
>     . tokens
>     . result
>     . str "\n\n"
>     . interleave' ",\n " 
>             [ mkActionName i | (i,action) <- zip [ 0 :: Int .. ] 
>                                             (assocs action) ]
>     . str " :: "
>     . intMaybeHash
>     . str " -> HappyReduction\n\n"
>     . interleave' ",\n " 
>             [ mkReduceFun i | 
>                     (i,action) <- zip [ 1 :: Int .. ]
>                                       (tail prods) ]
>     . str " :: HappyReduction\n\n" 

>     | otherwise = id

>	where intMaybeHash | ghc       = str "Int#"
>		           | otherwise = str "Int"
>	      token = brack token_type
>	      tokens = 
>     		case lexer of
>	  		Nothing -> char '[' . token . str "] -> "
>	  		Just _ -> id
>	      result = mkMonadTy (str res_type)
> 	      (Just res_type) = nt_types ! firstNT

%-----------------------------------------------------------------------------
Next, the reduction functions.   Each one has the following form:

happyReduce_n_m = happyReduce n m reduction where {
   reduction (
	(HappyAbsSynX  | HappyTerminal) happy_var_1 :
	..
	(HappyAbsSynX  | HappyTerminal) happy_var_q :
	happyRest)
	 = HappyAbsSynY
		( <<user supplied string>> ) : happyRest
	; reduction _ _ = notHappyAtAll n m

where n is the non-terminal number, and m is the rule number.

NOTES on monad productions.  These look like

	happyReduce_275 = happyMonadReduce 0# 119# happyReduction_275
	happyReduction_275 (happyRest)
	 	=  happyThen (code) (\r -> happyReturn (HappyAbsSyn r))

why can't we pass the HappyAbsSyn constructor to happyMonadReduce and
save duplicating the happyThen/happyReturn in each monad production?
Because this would require happyMonadReduce to be polymorphic in the
result type of the monadic action, and since in array-based parsers
the whole thing is one recursive group, we'd need a type signature on
happyMonadReduce to get polymorphic recursion.  Sigh.

>    produceReductions =
> 	interleave "\n\n" (zipWith produceReduction (tail prods) [ 1 .. ])

>    produceReduction (nt, toks, sem) i

>     | isMonadProd
>	= mkReductionHdr (showInt lt) "happyMonadReduce "
>	. char '(' . interleave " :\n\t" tokPatterns
>	. str "happyRest)\n\t = happyThen ("
>	. tokLets
>	. str code'
>	. str "\n\t) (\\r -> happyReturn (" . this_absSynCon . str " r))"
>       . defaultCase

>     | specReduceFun lt
>	= mkReductionHdr (shows lt) "happySpecReduce_"
>	. interleave "\n\t" tokPatterns
>	. str " =  "
>	. tokLets
>	. this_absSynCon . str "\n\t\t " 
>	. char '(' . str code' . str "\n\t)"
>	. (if coerce || null toks || null vars_used then
>		  id
>	   else
>		  nl . reductionFun . strspace
> 		. interleave " " (map str (take (length toks) (repeat "_")))
>		. str " = notHappyAtAll ")

>     | otherwise
> 	= mkReductionHdr (showInt lt) "happyReduce "
>	. char '(' . interleave " :\n\t" tokPatterns
>	. str "happyRest)\n\t = "
>	. tokLets
>	. this_absSynCon . str "\n\t\t " 
>	. char '(' . str code'. str "\n\t) : happyRest"
>	. defaultCase

>       where 
>		isMonadProd = case sem of ('%' : code) -> True
>			 		  _            -> False
> 
>		mkReductionHdr lt s = 
>			mkReduceFun i . str " = "
>			. str s . lt . strspace . showInt nt
>			. strspace . reductionFun . nl 
>			. reductionFun . strspace
> 
>		reductionFun = str "happyReduction_" . shows i
>
>		defaultCase = if not (null toks)
>              			  then nl . reductionFun
>				   . str " _ = notHappyAtAll "
>              			  else id
> 
>		tokPatterns 
>		 | coerce = reverse (map mkDummyVar [1 .. length toks])
>		 | otherwise = reverse (zipWith tokPattern [1..] toks)
> 
>		tokPattern n _ | n `notElem` vars_used = char '_'
>             	tokPattern n t | t >= startTok && t < fst_term
>	      		= if coerce 
>				then mkHappyVar n
>			  	else brack' (
>				     makeAbsSynCon t . str "  " . mkHappyVar n
>				     )
>		tokPattern n t
>			= if coerce
>				then mkHappyTerminalVar n t
>				else str "(HappyTerminal " 
>				   . mkHappyTerminalVar n t
>				   . char ')'
>		
>		tokLets 
>		   | coerce && not (null lines) = str "let {\n\t" 
>				   		. interleave "; \n\t" lines
>				   		. str "} in\n\t\t"
>		   | otherwise = id
>
>		   where lines = [ tokPattern n t . str " = " . 
>				   extract t . strspace .
>				   mkDummyVar n
>				 | (n,t) <- zip [1..] toks,
>				   n `elem` vars_used ]
>
>		extract t | t >= startTok && t < fst_term = mkHappyOut t
>			  | otherwise			  = str "happyOutTok"
>
>		(code,vars_used) = expandVars sem
>
>		code' 
>		    | isMonadProd = tail code  -- drop the '%'
>		    | otherwise   = code
>
>		maybe_ty = nt_types ! nt
>		has_ty = isJust maybe_ty
>		(Just ty) = maybe_ty
>
>		lt = length toks

>		this_absSynCon | coerce    = mkHappyIn nt
>			       | otherwise = makeAbsSynCon nt

%-----------------------------------------------------------------------------
The token conversion function.

>    produceTokenConverter
>	= case lexer of { 
> 
>	Nothing ->
>    	  str "happyNewToken action sts stk [] =\n\t"
>    	. eofAction
>	. str " []\n\n"
>       . str "happyNewToken action sts stk (tk:tks) =\n\t"
>	. str "let cont i = " . doAction . str " sts stk tks in\n\t"
>	. str "case tk of {\n\t"
>	. interleave ";\n\t" (map doToken token_rep)
>	. str "}\n";

>	Just (lexer,eof) ->
>	  str "happyNewToken action sts stk\n\t= "
>	. str lexer
>	. str "(\\tk -> "
>	. str "\n\tlet cont i = "
>	. doAction
>	. str " sts stk in\n\t"
>	. str "case tk of {\n\t"
>	. str (eof ++ " -> ")
>    	. eofAction . str ";\n\t"
>	. interleave ";\n\t" (map doToken token_rep)
>	. str "})\n"
>	}

>	where 

>	  eofAction = 
>	    (case target of
>	    	TargetArrayBased ->
>	   	  str "happyDoAction " . eofTok . eofError . str " action"
>	    	_ ->  str "action "	. eofTok . strspace . eofTok . eofError
>		    . str " (HappyState action)")
>	     . str " sts stk"
>	  eofError = str " (error \"reading EOF!\")"
>	  eofTok = showInt (tokIndex eof)
>	
>	  doAction = case target of
>	    TargetArrayBased -> str "happyDoAction i tk action"
>	    _   -> str "action i i tk (HappyState action)"
> 
>	  doToken (i,tok) 
>		= str (removeDollorDollor tok)
>		. str " -> cont " 
>		. showInt (tokIndex i)

Use a variable rather than '_' to replace '$$', so we can use it on
the left hand side of '@'.

>	  removeDollorDollor xs = case mapDollarDollar xs of
>				   Nothing -> xs
>				   Just fn -> fn "happy_dollar_dollar"

>    mkHappyTerminalVar :: Int -> Int -> String -> String
>    mkHappyTerminalVar i t = 
>     case tok_str_fn of
>	Nothing -> pat 
>	Just fn -> brack (fn (pat []))
>     where
>	  tok_str_fn = case lookup t token_rep of
>		      Nothing -> Nothing
>		      Just str -> mapDollarDollar str
>	  pat = mkHappyVar i

>    tokIndex 
>	= case target of
>		TargetHaskell 	 -> id
>		TargetArrayBased -> \i -> i - n_nonterminals - 3


%-----------------------------------------------------------------------------
Action Tables.

Here we do a bit of trickery and replace the normal default action
(failure) for each state with a reduction under the following
circumstances:

i)  there is at least one reduction action in this state.
ii) if there is more than one reduction action, they reduce using the same rule.

If these conditions hold, then the reduction becomes the default
action.  This should make the code smaller without affecting the
speed.  It changes the sematics for errors, however; errors could be
detected in a different state now.

Further notes on default cases:

Default reductions are important when error recovery is considered: we
don't allow reductions whilst in error recovery, so we'd like the
parser to automatically reduce down to a state where the error token
can be shifted before entering error recovery.  This is achieved by
using default reductions wherever possible.

One case to consider is:

State 345

	con -> conid .                                      (rule 186)
	qconid -> conid .                                   (rule 212)

	error          reduce using rule 212
	'{'            reduce using rule 186
	etc.

we should make reduce_212 the default reduction here.  So the rules become:

   * if there is a production 
	error -> reduce_n
     then make reduce_n the default action.
   * otherwise pick the most popular reduction in this state for the default.
   * if there are no reduce actions in this state, then the default
     action remains 'enter error recovery'.

This gives us an invariant: there won't ever be a production of the
type 'error -> reduce_n' explicitly in the grammar, which means that
whenever an unexpected token occurs, either the parser will reduce
straight back to a state where the error token can be shifted, or if
none exists, we'll get a parse error.  In theory, we won't need the
machinery to discard states in the parser...

>    produceActionTable TargetHaskell 
>	= foldr (.) id (map (produceStateFunction goto) (assocs action))
>	
>    produceActionTable TargetArrayBased
> 	= produceActionArray
>	. produceReduceArray
>	. str "happy_n_terms = " . shows n_terminals . str " :: Int\n"
>	. str "happy_n_nonterms = " . shows n_nonterminals . str " :: Int\n\n"

>    produceStateFunction goto (state, acts)
> 	= foldr (.) id (map produceActions assocs_acts)
>	. foldr (.) id (map produceGotos   (assocs gotos))
>	. mkActionName state
>	. (if ghc
>              then str " x = happyTcHack x "
>              else str " _ = ")
>	. mkAction default_act
>	. str "\n\n"
>
>	where gotos = goto ! state
>	
>	      produceActions (t, LR'Fail{-'-}) = id
>	      produceActions (t, action@(LR'Reduce{-'-} _))
>	      	 | action == default_act = id
>		 | otherwise = actionFunction t
>			     . mkAction action . str "\n"
>	      produceActions (t, action)
>	      	= actionFunction t
>		. mkAction action . str "\n"
>		
>	      produceGotos (t, Goto i)
>	        = actionFunction t
>		. str "happyGoto " . mkActionName i . str "\n"
>	      produceGotos (t, NoGoto) = id
>	      
>	      actionFunction t
>	      	= mkActionName state . strspace
>		. ('(' :) . showInt t
>		. str ") = "
>		
> 	      default_act = getDefault assocs_acts
>
>	      assocs_acts = assocs acts

action array indexed by (terminal * last_state) + state

>    produceActionArray
>	| ghc
>	    = str "happyActOffsets :: Addr\n"
>	    . str "happyActOffsets = A# \"" --"
>	    . str (hexChars act_offs)
>	    . str "\"#\n\n" --"
>	
>	    . str "happyGotoOffsets :: Addr\n"
>	    . str "happyGotoOffsets = A# \"" --"
>	    . str (hexChars goto_offs)
>	    . str "\"#\n\n"  --"
>
>	    . str "happyDefActions :: Addr\n"
>	    . str "happyDefActions = A# \"" --"
>	    . str (hexChars defaults)
>	    . str "\"#\n\n" --"
>	
>	    . str "happyCheck :: Addr\n"
>	    . str "happyCheck = A# \"" --"
>	    . str (hexChars check)
>	    . str "\"#\n\n" --"
>	
>	    . str "happyTable :: Addr\n"
>	    . str "happyTable = A# \"" --"
>	    . str (hexChars table)
>	    . str "\"#\n\n" --"

>	| otherwise
>	    = str "happyActOffsets :: Array Int Int\n"
>	    . str "happyActOffsets = listArray (0," 
>		. shows (n_states) . str ") (["
>	    . interleave' "," (map shows act_offs)
>	    . str "\n\t])\n\n"
>	
>	    . str "happyGotoOffsets :: Array Int Int\n"
>	    . str "happyGotoOffsets = listArray (0," 
>		. shows (n_states) . str ") (["
>	    . interleave' "," (map shows goto_offs)
>	    . str "\n\t])\n\n"
>	
>	    . str "happyDefActions :: Array Int Int\n"
>	    . str "happyDefActions = listArray (0," 
>		. shows (n_states) . str ") (["
>	    . interleave' "," (map shows defaults)
>	    . str "\n\t])\n\n"
>	
>	    . str "happyCheck :: Array Int Int\n"
>	    . str "happyCheck = listArray (0," 
>		. shows (n_states * n_terminals) . str ") (["
>	    . interleave' "," (map shows check)
>	    . str "\n\t])\n\n"
>	
>	    . str "happyTable :: Array Int Int\n"
>	    . str "happyTable = listArray (0," 
>		. shows (n_states * n_terminals) . str ") (["
>	    . interleave' "," (map shows table)
>	    . str "\n\t])\n\n"
>	
>    (_, last_state) = bounds action
>    n_states = last_state + 1
>    n_terminals = length terms
>    n_nonterminals = length nonterms - 1 -- lose one for %start
>
>    (act_offs,goto_offs,table,defaults,check) 
>	= mkTables action goto n_terminals (n_nonterminals+1)
>
>    actionArrElems actions = map (actionVal) 
>				 (e : drop (n_nonterminals + 1) line)
>	where (e:d:line)  = elems actions
>	      default_act = getDefault (assocs actions)

>    produceReduceArray
>   	= {- str "happyReduceArr :: Array Int a\n" -}
>	  str "happyReduceArr = array ("
>		. shows (1 :: Int)
>		. str ", "
>		. shows n_rules
>		. str ") [\n"
>	. interleave' ",\n" (map reduceArrElem [1..n_rules])
>	. str "\n\t]\n\n"

>    n_rules = length prods - 1 :: Int

>    showInt i | ghc       = shows i . showChar '#'
>	       | otherwise = shows i

This lets examples like:

	data HappyAbsSyn t1
		= HappyTerminal ( HaskToken )
		| HappyAbsSyn1 (  HaskExp  )
		| HappyAbsSyn2 (  HaskExp  )
		| HappyAbsSyn3 t1

*share* the defintion for ( HaskExp )

	data HappyAbsSyn t1
		= HappyTerminal ( HaskToken )
		| HappyAbsSyn1 (  HaskExp  )
		| HappyAbsSyn3 t1

... cuting down on the work that the type checker has to do.

Note, this *could* introduce lack of polymophism,
for types that have alphas in them. Maybe we should
outlaw them inside { }

>    nt_types_index :: Array Int Int
>    nt_types_index = array (bounds nt_types) 
>			[ (a, fn a b) | (a, b) <- assocs nt_types ]
>     where
>	fn n Nothing = n
>	fn n (Just a) = case lookup a assoc_list of
>			  Just v -> v
>			  Nothing -> error ("cant find an item in list")
>	assoc_list = [ (b,a) | (a, Just b) <- assocs nt_types ]

>    makeAbsSynCon = mkAbsSynCon nt_types_index

>    mkMonadTy s = case monad of
>			Nothing -> s
>			Just (ty,_,_) -> str (ty++"(") . s . char ')'

>    produceMonadStuff =
>	(case monad of
>	  Nothing -> 
>            str "happyThen = \\m k -> k m\n" .
>	     str "happyReturn = " .
>            (case lexer of 
>		  Nothing -> str "\\a tks -> a"
>		  _       -> str "\\a -> a")
>	  Just (ty,tn,rtn) ->
>	     case lexer of
>		Nothing ->
>		   str "happyThen m k tks = (" . str tn 
>		 . str ") m (\\a -> k a tks)\n"
>		 . str "happyReturn = \\a tks -> " . brack rtn
>		 . str " a\n"
>		_ ->
>                  let pty = str ty in
>                  str "happyThen :: " . pty
>                . str " a -> (a -> "  . pty
>	         . str " b) -> " . pty . str " b\n"
>                . str "happyThen = " . brack tn . char '\n'
>                . str "happyReturn = " . brack rtn
>	)
>	. str "\n"

>    reduceArrElem n
>      = str "\t(" . shows n . str " , "
>      . str "happyReduce_" . shows n . char ')'

-----------------------------------------------------------------------------
Replace all the $n variables with happy_vars, and return a list of all the
vars used in this piece of code.

>    expandVars :: String -> (String,[Int])
>    expandVars [] = ("",[])
>    expandVars ('$':r) 
>    	   | isDigit (head r) = ("happy_var_" ++ num ++ code, read num : vars)
>    	   | otherwise = error ("Illegal attribute: $" ++ [head r] ++ "\n")
>    	where
>    	   (num,rest)  = span isDigit r
>    	   (code,vars) = expandVars rest
>    expandVars (c:r) = (c:code,vars)
>    	where
>	(code,vars) = expandVars r

> actionVal :: LRAction -> Int
> actionVal (LR'Shift  state) 	= state + 1
> actionVal (LR'Reduce rule)  	= -(rule + 1)
> actionVal  LR'Accept		= -1
> actionVal (LR'Multiple _ a)	= actionVal a
> actionVal LR'Fail		= 0

> gotoVal :: Goto -> Int
> gotoVal (Goto i)		= i
> gotoVal NoGoto		= 0
  
> mkAction (LR'Shift i)	 	= str "happyShift " . mkActionName i
> mkAction LR'Accept 	 	= str "happyAccept"
> mkAction LR'Fail 	 	= str "happyFail"
> mkAction (LR'Reduce i) 	= str "happyReduce_" . shows i
> mkAction (LR'Multiple as a)	= mkAction a

> mkActionName i		= str "action_" . shows i

> getDefault actions =
>   case [ act | (errorTok, act@(LR'Reduce{-'-} _)) <- actions ] of
>	(act:_) -> act	-- use error reduction if there is one.
>	[] ->
>	    case reduces of
>		 [] -> LR'Fail
>		 (act:_) -> act	-- pick the first one we see for now
>
>   where reduces = [ act | (_,act@(LR'Reduce{-'-} _)) <- actions ]
>   		    ++ [ act | (_,(LR'Multiple{-'-} _ 
>					act@(LR'Reduce{-'-} _))) <- actions ]

-----------------------------------------------------------------------------
-- Generate packed parsing tables.

-- happyActOff ! state
--     Offset within happyTable of actions for state

-- happyGotoOff ! state
--     Offset within happyTable of gotos for state

-- happyTable
--	Combined action/goto table

-- happyDefAction ! state
-- 	Default action for state

-- happyCheck
--	Indicates whether we should use the default action for state


-- the table is laid out such that the action for a given state & token
-- can be found by:
--
--        off    = happyActOff ! state
--	  off_i  = off + token
--	  check  | off_i => 0 = happyCheck ! off_i
--		 | otherwise  = False
--	  action | check      = happyTable ! off_i
--	         | otherwise  = happyDefAaction ! off_i


-- figure out the default action for each state.  This will leave some
-- states with no *real* actions left.

-- for each state with one or more real actions, sort states by
-- width/spread of tokens with real actions, then by number of
-- elements with actions, so we get the widest/densest states
-- first. (I guess the rationale here is that we can use the
-- thin/sparse states to fill in the holes later, and also we
-- have to do less searching for the more complicated cases).

-- try to pair up states with identical sets of real actions.

-- try to fit the actions into the check table, using the ordering
-- from above.


> mkTables 
>	 :: ActionTable -> GotoTable -> Int -> Int -> 
>	 ([Int]		-- happyActOffsets
>	 ,[Int]		-- happyGotoOffsets
>	 ,[Int]		-- happyTable
>	 ,[Int]		-- happyDefAction
>	 ,[Int]		-- happyCheck
>	 )
>
> mkTables action goto n_terminals n_nonterminals
>  = ( elems act_offs, 
>      elems goto_offs, 
>      take max_off (elems table),
>      def_actions, 
>      take max_off (elems check)
>   )
>  where 
>
>	 (table,check,act_offs,goto_offs,max_off) 
>		 = runST (genTables (length actions) n_terminals
>				 mAX_TABLE_SIZE sorted_actions)
>	 
>	 def_actions = map (\(_,_,def,_,_,_) -> def) actions
>
>	 actions :: [TableEntry]
>	 actions = 
>		 [ (ActionEntry,
>		    state,
>		    actionVal default_act,
>		    if null acts'' then 0 
>			 else fst (last acts'') - fst (head acts''),
>		    length acts'',
>		    acts'')
>		 | (state, acts) <- assocs action,
>		   let (e:d:vec) = assocs acts
>		       vec' = drop n_nonterminals vec
>		       acts' = filter (notFail) (e:vec')
>		       default_act = getDefault acts'
>		       acts'' = mkActVals acts' default_act
>		 ]
>
>	 -- adjust terminals by non_terminals-2, so they start at zero
>	 --  (see ARRAY_NOTES)
>	 adjust token | token == errorTok = 0
>		      | otherwise         = token - n_nonterminals - 2
>
>	 mkActVals assocs default_act = 
>		 [ (adjust token, actionVal act) 
>		 | (token, act) <- assocs
>		 , act /= default_act ]
>
>	 gotos :: [TableEntry]
>	 gotos = [ (GotoEntry,
>		    state, 0, 
>		    if null goto_vals then 0 
>			 else fst (last goto_vals) - fst (head goto_vals),
>		    length goto_vals,
>		    goto_vals
>		   )
>		 | (state, goto_arr) <- assocs goto,
>		 let goto_vals = mkGotoVals (assocs goto_arr)
>		 ]
>
>	 -- adjust nonterminals by -4, so they start at zero
>	 --  (see ARRAY_NOTES)
>	 mkGotoVals assocs =
>		 [ (token-4, i) | (token, Goto i) <- assocs ]
>
>	 sorted_actions = reverse (sortBy cmp_state (actions++gotos))
>	 cmp_state (_,_,_,width1,tally1,_) (_,_,_,width2,tally2,_)
>		 | width1 < width2  = LT
>		 | width1 == width2 = compare tally1 tally2
>		 | otherwise = GT
>
>	 n_states = length actions - 1
>	 mAX_TABLE_SIZE = n_states * n_terminals

> data ActionOrGoto = ActionEntry | GotoEntry
> type TableEntry = (ActionOrGoto,
>			Int{-stateno-},
>			Int{-default-},
>			Int{-width-},
>			Int{-tally-},
>			[(Int,Int)])

> genTables
>	 :: Int				-- number of actions
>	 -> Int				-- number of terminals
>	 -> Int				-- max table size (states * terminals)
>	 -> [TableEntry]			-- entries for the table
>	 -> ST s (UArray Int Int,	-- table
>		  UArray Int Int,	-- check
>		  UArray Int Int,	-- action offsets
>		  UArray Int Int,	-- goto offsets
>		  Int 	   		-- highest offset in table
>	    )
>
> genTables n_actions n_terminals max_table_size entries = do
>
>   table      <- fillNewArray (0, max_table_size) 0
>   check      <- fillNewArray (0, max_table_size) (-1)
>   act_offs   <- fillNewArray (0, n_actions) 0
>   goto_offs  <- fillNewArray (0, n_actions) 0
>   off_arr    <- fillNewArray (-n_terminals, max_table_size) 0
>
>   max_off <- genTables' table check act_offs goto_offs off_arr entries
>
>   table'     <- freeze table
>   check'     <- freeze check
>   act_offs'  <- freeze act_offs
>   goto_offs' <- freeze goto_offs
>   return (table',check',act_offs',goto_offs',max_off+1)


> genTables' table check act_offs goto_offs off_arr entries
>	= fit_all entries 0 1
>   where
>
>	 fit_all [] max_off fst_zero = return max_off
>	 fit_all (s:ss) max_off fst_zero = do
>	   (off, new_max_off, new_fst_zero) <- fit s max_off fst_zero
>	   ss' <- same_states s ss off
>	   writeArray off_arr off 1
>	   fit_all ss' new_max_off new_fst_zero
>
>	 -- try to merge identical states.  We only try the next state(s)
>	 -- in the list, but the list is kind-of sorted so we shouldn't
>	 -- miss too many.
>	 same_states s [] off = return []
>	 same_states s@(_,_,_,_,_,acts) ss@((e,no,_,_,_,acts'):ss') off
>	   | acts == acts' = do writeArray (which_off e) no off
>				same_states s ss' off
>	   | otherwise = return ss
>  
>	 which_off ActionEntry = act_offs
>	 which_off GotoEntry   = goto_offs
>
>	 -- fit a vector into the table.  Return the offset of the vector,
>	 -- the maximum offset used in the table, and the offset of the first
>	 -- entry in the table (used to speed up the lookups a bit).
>	 fit (_,_,_,_,_,[]) max_off fst_zero = return (0,max_off,fst_zero)
>
>	 fit (act_or_goto, state_no, deflt, _, _, state@((t,_):_)) 
>	    max_off fst_zero = do
>		 -- start at offset 1 in the table: all the empty states
>		 -- (states with just a default reduction) are mapped to
>		 -- offset zero.
>	   off <- findFreeOffset (-t+fst_zero) table off_arr state
>	   let new_max_off | furthest_right > max_off = furthest_right
>			   | otherwise                = max_off
>	       (last_tok,_) = last state
>	       furthest_right = last_tok + off
>
>  --trace ("fit: state " ++ show state_no ++ ", off " ++ show off ++ ", elems " ++ show state) $ do
>
>	   writeArray (which_off act_or_goto) state_no off
>	   addState off table check state
>	   new_fst_zero <- findFstZero table fst_zero
>	   return (off, new_max_off, new_fst_zero)


> -- Find a valid offset in the table for this state.
> findFreeOffset off table off_arr state = do
>     -- offset 0 isn't allowed
>   if off == 0 then try_next else do
>
>     -- don't use an offset we've used before
>   b <- readArray off_arr off
>   if b /= 0 then try_next else do
>
>     -- check whether the actions for this state fit in the table
>   ok <- fits off state table
>   if not ok then try_next else return off
>  where
> 	try_next = findFreeOffset (off+1) table off_arr state


> fits :: Int -> [(Int,Int)] -> STUArray s Int Int -> ST s Bool
> fits off [] table = return True
> fits off ((t,_):rest) table = do
>   i <- readArray table (off+t)
>   if i /= 0 then return False
>	      else fits off rest table

> addState off table check [] = return ()
> addState off table check ((t,val):state) = do
>    writeArray table (off+t) val
>    writeArray check (off+t) t
>    addState off table check state

> notFail (t,LR'Fail) = False
> notFail _           = True

> findFstZero :: STUArray s Int Int -> Int -> ST s Int
> findFstZero table n = do
>	 i <- readArray table n
>	 if i == 0 then return n
>		   else findFstZero table (n+1)

#if __GLASGOW_HASKELL__ >= 408

> fillNewArray :: (Int,Int) -> Int -> ST s (STUArray s Int Int)
> fillNewArray bounds val = do 
>   a <- newArray bounds
>   sequence_ [ writeArray a i val | i <- marray_indices a ]
>   return a

#else

> fillNewArray :: (Int,Int) -> Int -> ST s (STUArray s Int Int)
> fillNewArray = newSTArray

#endif

-----------------------------------------------------------------------------
-- Misc.

> comment = 
>	  "-- parser produced by Happy Version " ++ version ++ "\n\n"

> str = showString
> char c = (c :)
> interleave s = foldr (\a b -> a . str s . b) id
> interleave' s = foldr1 (\a b -> a . str s . b) 

> strspace = char ' '
> nl = char '\n'

> mkAbsSynCon fx t    	= str "HappyAbsSyn"   . shows (fx ! t)
> mkHappyVar n     	= str "happy_var_"    . shows n
> mkReduceFun n 	= str "happyReduce_"  . shows n
> mkDummyVar n		= str "happy_x_"      . shows n

> mkHappyIn n 		= str "happyIn"  . shows (n :: Int)
> mkHappyOut n 		= str "happyOut" . shows (n :: Int)

> type_param :: Int -> Maybe String -> ShowS
> type_param n Nothing   = char 't' . shows (n :: Int)
> type_param n (Just ty) = brack ty

> specReduceFun 	= (<= (3 :: Int))

> maybestr (Just s)	= str s
> maybestr _		= id

> mapDollarDollar :: String -> Maybe (String -> String)
> mapDollarDollar "" = Nothing
> mapDollarDollar ('$':'$':r) = -- only map first instance
>    case mapDollarDollar r of
>	  Just fn -> error "more that one $$ in pattern"
>	  Nothing -> Just (\ s -> s ++ r)
> mapDollarDollar (c:r) =
>    case mapDollarDollar r of
>	  Just fn -> Just (\ s -> c : fn s)
>	  Nothing -> Nothing

> brack s = str ('(' : s) . char ')'
> brack' s = char '(' . s . char ')'

-----------------------------------------------------------------------------
-- Convert an integer to a 16-bit number encoded in \xNN\xNN format suitable
-- for placing in a string.

> hexChars :: [Int] -> String
> hexChars acts = concat (map hexChar acts)

> hexChar :: Int -> String
> hexChar i | i < 0 = hexChar (i + 2^16)
> hexChar i =  toHex (i `mod` 256) ++ toHex (i `div` 256)

> toHex i = ['\\','x', hexDig (i `div` 16), hexDig (i `mod` 16)]

> hexDig i | i <= 9    = chr (i + ord '0')
>	   | otherwise = chr (i - 10 + ord 'a')

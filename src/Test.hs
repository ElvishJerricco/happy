-- parser produced by Happy Version 1.1-simonm


data HappyAbsSyn t1 t2 t3 t4
	= HappyTerminal Token
	| HappyAbsSyn1 t1
	| HappyAbsSyn2 t2
	| HappyAbsSyn3 t3
	| HappyAbsSyn4 t4

action_0 (5) = happyShift action_5
action_0 (7) = happyShift action_6
action_0 (8) = happyShift action_7
action_0 (14) = happyShift action_8
action_0 (1) = happyGoto action_1
action_0 (2) = happyGoto action_2
action_0 (3) = happyGoto action_3
action_0 (4) = happyGoto action_4
action_0 _ = happyFail

action_1 (16) = happyAccept
action_1 _ = happyFail

action_2 (10) = happyShift action_13
action_2 (11) = happyShift action_14
action_2 _ = happyReduce_2

action_3 (12) = happyShift action_11
action_3 (13) = happyShift action_12
action_3 _ = happyReduce_5

action_4 _ = happyReduce_8

action_5 (8) = happyShift action_10
action_5 _ = happyFail

action_6 _ = happyReduce_9

action_7 _ = happyReduce_10

action_8 (5) = happyShift action_5
action_8 (7) = happyShift action_6
action_8 (8) = happyShift action_7
action_8 (14) = happyShift action_8
action_8 (1) = happyGoto action_9
action_8 (2) = happyGoto action_2
action_8 (3) = happyGoto action_3
action_8 (4) = happyGoto action_4
action_8 _ = happyFail

action_9 (15) = happyShift action_20
action_9 _ = happyFail

action_10 (9) = happyShift action_19
action_10 _ = happyFail

action_11 (7) = happyShift action_6
action_11 (8) = happyShift action_7
action_11 (14) = happyShift action_8
action_11 (4) = happyGoto action_18
action_11 _ = happyFail

action_12 (7) = happyShift action_6
action_12 (8) = happyShift action_7
action_12 (14) = happyShift action_8
action_12 (4) = happyGoto action_17
action_12 _ = happyFail

action_13 (7) = happyShift action_6
action_13 (8) = happyShift action_7
action_13 (14) = happyShift action_8
action_13 (3) = happyGoto action_16
action_13 (4) = happyGoto action_4
action_13 _ = happyFail

action_14 (7) = happyShift action_6
action_14 (8) = happyShift action_7
action_14 (14) = happyShift action_8
action_14 (3) = happyGoto action_15
action_14 (4) = happyGoto action_4
action_14 _ = happyFail

action_15 (12) = happyShift action_11
action_15 (13) = happyShift action_12
action_15 _ = happyReduce_4

action_16 (12) = happyShift action_11
action_16 (13) = happyShift action_12
action_16 _ = happyReduce_3

action_17 _ = happyReduce_7

action_18 _ = happyReduce_6

action_19 (5) = happyShift action_5
action_19 (7) = happyShift action_6
action_19 (8) = happyShift action_7
action_19 (14) = happyShift action_8
action_19 (1) = happyGoto action_21
action_19 (2) = happyGoto action_2
action_19 (3) = happyGoto action_3
action_19 (4) = happyGoto action_4
action_19 _ = happyFail

action_20 _ = happyReduce_11

action_21 (6) = happyShift action_22
action_21 _ = happyFail

action_22 (5) = happyShift action_5
action_22 (7) = happyShift action_6
action_22 (8) = happyShift action_7
action_22 (14) = happyShift action_8
action_22 (1) = happyGoto action_23
action_22 (2) = happyGoto action_2
action_22 (3) = happyGoto action_3
action_22 (4) = happyGoto action_4
action_22 _ = happyFail

action_23 _ = happyReduce_1

happyReduce_1 = happyReduce 6 1 reduction where {
  reduction
	((HappyAbsSyn1  happy_var_6) :
	_ :
	(HappyAbsSyn1  happy_var_4) :
	_ :
	(HappyTerminal (TokenVar happy_var_2)) :
	_ :
	happyRest)
	 = HappyAbsSyn1
		 (Let happy_var_2 happy_var_4 happy_var_6) : happyRest;
  reduction _ = notHappyAtAll }

happyReduce_2 = happySpecReduce_1 1 reduction where {
  reduction
	(HappyAbsSyn2  happy_var_1)
	 =  HappyAbsSyn1
		 (Exp1 happy_var_1);
  reduction _  = notHappyAtAll }

happyReduce_3 = happySpecReduce_3 2 reduction where {
  reduction
	(HappyAbsSyn3  happy_var_3)
	_
	(HappyAbsSyn2  happy_var_1)
	 =  HappyAbsSyn2
		 (Plus happy_var_1 happy_var_3);
  reduction _ _ _  = notHappyAtAll }

happyReduce_4 = happySpecReduce_3 2 reduction where {
  reduction
	(HappyAbsSyn3  happy_var_3)
	_
	(HappyAbsSyn2  happy_var_1)
	 =  HappyAbsSyn2
		 (Minus happy_var_1 happy_var_3);
  reduction _ _ _  = notHappyAtAll }

happyReduce_5 = happySpecReduce_1 2 reduction where {
  reduction
	(HappyAbsSyn3  happy_var_1)
	 =  HappyAbsSyn2
		 (Term happy_var_1);
  reduction _  = notHappyAtAll }

happyReduce_6 = happySpecReduce_3 3 reduction where {
  reduction
	(HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn3  happy_var_1)
	 =  HappyAbsSyn3
		 (Times happy_var_1 happy_var_3);
  reduction _ _ _  = notHappyAtAll }

happyReduce_7 = happySpecReduce_3 3 reduction where {
  reduction
	(HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn3  happy_var_1)
	 =  HappyAbsSyn3
		 (Div happy_var_1 happy_var_3);
  reduction _ _ _  = notHappyAtAll }

happyReduce_8 = happySpecReduce_1 3 reduction where {
  reduction
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn3
		 (Factor happy_var_1);
  reduction _  = notHappyAtAll }

happyReduce_9 = happySpecReduce_1 4 reduction where {
  reduction
	(HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn4
		 (Int happy_var_1);
  reduction _  = notHappyAtAll }

happyReduce_10 = happySpecReduce_1 4 reduction where {
  reduction
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn4
		 (Var happy_var_1);
  reduction _  = notHappyAtAll }

happyReduce_11 = happySpecReduce_3 4 reduction where {
  reduction
	_
	(HappyAbsSyn1  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Brack happy_var_2);
  reduction _ _ _  = notHappyAtAll }

happyNewToken action sts stk [] =
	action 16 16 (error "reading EOF!") (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenLet -> cont 5;
	TokenIn -> cont 6;
	TokenInt _ -> cont 7;
	TokenVar _ -> cont 8;
	TokenEq -> cont 9;
	TokenPlus -> cont 10;
	TokenMinus -> cont 11;
	TokenTimes -> cont 12;
	TokenDiv -> cont 13;
	TokenOB -> cont 14;
	TokenCB -> cont 15;
	}

happyThen = \m k -> k m
happyReturn = \a -> a
calc = happyParse







happyError :: Int -> [Token] -> a
happyError i _ = error ("Parse error in line " ++ show i ++ "\n")



data Exp  = Let String Exp Exp | Exp1 Exp1 
data Exp1 = Plus Exp1 Term | Minus Exp1 Term | Term Term 
data Term = Times Term Factor | Div Term Factor | Factor Factor 
data Factor = Int Int | Var String | Brack Exp 



data Token
	= TokenLet
	| TokenIn
	| TokenInt Int
	| TokenVar String
	| TokenEq
	| TokenPlus
	| TokenMinus
	| TokenTimes
	| TokenDiv
	| TokenOB
	| TokenCB



lexer :: String -> [Token]
lexer [] = []
lexer (c:cs) 
	| isSpace c = lexer cs
	| isAlpha c = lexVar (c:cs)
	| isDigit c = lexNum (c:cs)
lexer ('=':cs) = TokenEq : lexer cs
lexer ('+':cs) = TokenPlus : lexer cs
lexer ('-':cs) = TokenMinus : lexer cs
lexer ('*':cs) = TokenTimes : lexer cs
lexer ('/':cs) = TokenDiv : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs

lexNum cs = TokenInt (read num) : lexer rest
	where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
	("let",rest) -> TokenLet : lexer rest
	("in",rest)  -> TokenIn : lexer rest
	(var,rest)   -> TokenVar var : lexer rest




runCalc :: String -> Exp
runCalc = calc . lexer



main = case runCalc "1 + 2 + 3" of {
	(Exp1 (Plus (Plus (Term (Factor (Int 1))) (Factor (Int 2))) (Factor (Int 3))))  ->
	case runCalc "1 * 2 + 3" of {
	(Exp1 (Plus (Term (Times (Factor (Int 1)) (Int 2))) (Factor (Int 3)))) ->
	case runCalc "1 + 2 * 3" of {
	(Exp1 (Plus (Term (Factor (Int 1))) (Times (Factor (Int 2)) (Int 3)))) ->
	case runCalc "let x = 2 in x * (x - 2)" of {
	(Let "x" (Exp1 (Term (Factor (Int 2)))) (Exp1 (Term (Times (Factor (Var "x")) (Brack (Exp1 (Minus (Term (Factor (Var "x"))) (Factor (Int 2))))))))) -> appendChan stdout "Test works\n" abort done; 
	_ -> quit } ; _ -> quit } ; _ -> quit } ; _ -> quit }
quit = appendChan stdout "Test failed\n" abort done

-- $Id: Test.hs,v 1.1.1.1 1997/02/11 13:12:10 simonm Exp $

{-
	The stack is in the following order throughout the parse:

	i	current token number
	j	another copy of this to avoid messing with the stack
	tk	current token semantic value
	st	current state
	sts	state stack
	stk	semantic stack
-}

-----------------------------------------------------------------------------

happyParse = happyNewToken action_0 [] []

-- All this HappyState stuff is simply because we can't have recursive
-- types in Haskell without an intervening data structure.

data HappyState b c = HappyState
        (Int ->                         -- token number
         Int ->                         -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)

-----------------------------------------------------------------------------
-- Accepting the parse

happyAccept j tk st sts [ HappyAbsSyn1 ans ] = happyReturn ans
happyAccept j tk st sts _                    = notHappyAtAll

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (-1) tk@(ErrorTok i tk') st sts stk =
--     _trace "shifting the error token" $
     new_state i i tk' (HappyState new_state) (st:sts) (HappyTerminal tk:stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (st:sts) (HappyTerminal tk:stk)

-----------------------------------------------------------------------------
-- Reducing

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn j tk st@(HappyState action) sts stk
     = action i j tk st (st:sts) (fn : stk)
happySpecReduce_1 i fn j tk _ sts@(st@(HappyState action):_) (v1:stk')
     = action i j tk st sts (fn v1 : stk')
happySpecReduce_2 i fn j tk _ (_:sts@(st@(HappyState action):_)) (v1:v2:stk')
     = action i j tk st sts (fn v1 v2 : stk')
happySpecReduce_3 i fn j tk _ (_:_:sts@(st@(HappyState action):_)) 
	(v1:v2:v3:stk')
     = action i j tk st sts (fn v1 v2 v3 : stk')

happyReduce k i fn j tk st sts stk = action i j tk st' sts' (fn stk)
       where sts'@(st'@(HappyState action):_) = drop (k::Int) (st:sts)

happyMonadReduce k i c fn j tk st sts stk =
	happyThen (fn stk) (\r -> action i j tk st' sts' (c r : stk'))
       where sts'@(st'@(HappyState action):_) = drop (k::Int) (st:sts)
	     stk' = drop (k::Int) stk

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

happyGoto action j tk st = action j j tk (HappyState action)

-----------------------------------------------------------------------------
-- Error recovery (-1 is the error token)

-- fail if we are in recovery and no more states to discard
happyFail  (-1) tk st' [] stk = happyError

-- discard a state
happyFail  (-1) tk st' (st@(HappyState action):sts) stk =
--	_trace "discarding state" $
	action (-1) (-1) tk st sts stk

-- Enter error recovery: generate an error token,
-- 			 save the old token and carry on.
happyFail  i tk st@(HappyState action) sts stk =
--	_trace "entering error recovery" $
	action (-1) (-1) (ErrorTok i tk) st sts stk

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-- end of Happy Template.


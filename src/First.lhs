-----------------------------------------------------------------------------
$Id: First.lhs,v 1.5 1999/03/11 17:15:57 simonm Exp $

Implementation of FIRST

(c) 1993-1996 Andy Gill, Simon Marlow
-----------------------------------------------------------------------------

> module First (mkFirst ) where

> import GenUtils
> import Set
> import AbsSyn
> import Grammar

\subsection{Utilities}

> joinSymSets :: (a -> Set Name) -> [a] -> Set Name
> joinSymSets f = foldr 
>       (\ h b -> let
>                   h' = f h
>                 in
>                    if incEmpty h'
>                    then filterSet (not. isEmpty) h' `union_Int` b
>                    else h')
>        (singletonSet epsilonTok)

Does the Set include the $\epsilon$ symbol ?

> incEmpty :: Set Name -> Bool
> incEmpty set = any isEmpty (setToList set)

\subsection{Implementation of FIRST}

> mkFirst :: Grammar -> [Name] -> Set Name
> mkFirst (Grammar { first_term = fst_term
>		   , lookupProdNo = prodNo
>		   , lookupProdsOfName = prodsOfName
>		   , non_terminals = nts
>		   })
>       = joinSymSets (\ h -> case lookup h env of
>                               Nothing -> singletonSet h
>                               Just ix -> ix)
>   where
>       env = mkClosure (==) (getNext fst_term prodNo prodsOfName)
>               [ (name,emptySet) | name <- nts ]

> getNext fst_term prodNo prodsOfName env = 
>		[ (nm, next nm) | (nm,_) <- env ]
>    where 
>    	fn t | t == errorTok || t >= fst_term = singletonSet t
>    	fn x = case lookup x env of
>           	        Just t -> t
>                       Nothing -> error "attempted FIRST(e) :-("

> 	next :: Name -> Set Name
> 	next t | t >= fst_term = singletonSet t
> 	next n = 
>       	foldb union_Int 
>               	[ joinSymSets fn (snd3 (prodNo rl)) | 
>				rl <- prodsOfName n ]

-------------------------------------------------------------------------------
--		    ALEX SCANNER AND LITERATE PREPROCESSOR
-- 
-- This Script defines the grammar used to generate the Alex scanner and a
-- preprocessing scanner for dealing with literate scripts.  The actions for
-- the Alex scanner are given separately in the Alex module.
--  
-- See the Alex manual for a discussion of the scanners defined here.
--  
-- Chris Dornan, Aug-95, 4-Jun-96, 10-Jul-96, 29-Sep-97
-------------------------------------------------------------------------------

{
module Scan(lexer) where

import Alex
import AbsSyn

import qualified Array
import Data.Char
import Debug.Trace
}

$digit    = 0-9
$lower    = a-z
$upper    = A-Z
$alpha    = [$upper $lower]
$alphanum = [$alpha $digit]
$idchar   = [$alphanum \_ \']

%id     = $alpha $idchar*
%smac   = \$ %id | \$ \{ %id \}
%rmac   = \% %id | \% \{ %id \}

%comment = \-\-.*
%ws      = $white+ | %comment

alex :-

%ws				{ skip }	-- white space; ignore

<0> \. | \; | \, | \/ | \\
  | \| | \* | \+ | \? | \#
  | \~ | \- | \}
  | \( | \) | \[ | \] | \^	{ special }
<0> \{			{ brace }

<0> \" (.#\")* \"		{ string }
<0> %id %ws? \:\-		{ bind }
<0> \\ $digit{1,3}		{ cch }
<0> \\ $printable		{ escape }
<0> $alphanum			{ char }
<0> %smac			{ smac }
<0> %rmac			{ rmac }
<0> %smac %ws? \=		{ smacdef }
<0> %rmac %ws? \=		{ rmacdef }

-- TODO: deal with nested comments in code ({- ... -})
<0> \{ [^$digit \}]		{ begin incode nest_code }  
<incode> [^\{\}]+		{ code }
<incode> \{			{ nest_code }
<incode> \}			{ unnest_code }

-- identifiers are allowed to be unquoted in startcode lists
<0> 		\< 		{ begin startcodes special }
<startcodes>	0		{ zero }
<startcodes>	%id		{ startcode }
<startcodes>	\,		{ special }
<startcodes> 	\> 		{ begin 0 special }

{
special = mk_act (\p ln str -> T p (SpecialT  (head str)))
brace   = mk_act (\p ln str -> T p (SpecialT  '\123'))
zero    = mk_act (\p ln str -> T p ZeroT)
string  = mk_act (\p ln str -> T p (StringT (extract ln str)))
bind    = mk_act (\p ln str -> T p (BindT (takeWhile isIdChar str)))
escape  = mk_act (\p ln str -> T p (CharT (esc str)))
cch     = mk_act (\p ln str -> T p (CharT (do_cch ln str)))
char    = mk_act (\p ln str -> T p (CharT (head str)))
smac    = mk_act (\p ln str -> T p (SMacT (mac ln str)))
rmac    = mk_act (\p ln str -> T p (RMacT (mac ln str)))
smacdef = mk_act (\p ln str -> T p (SMacDefT (macdef ln str)))
rmacdef = mk_act (\p ln str -> T p (RMacDefT (macdef ln str)))
startcode = mk_act (\p ln str -> T p (IdT (take ln str)))

isIdChar c = isAlphaNum c || c `elem` "_'"

skip p c input len cont scs = 
  -- trace ("skip: " ++ take len input) $
  cont scs

-- begin a new startcode
begin startcode tok p c input len cont (_,s) = 
  tok p c input len cont (startcode,s)

-- the state is the level of brace nesting in code
nest_code p c input len cont (sc,(0,_)) =
  cont (sc,(1,""))
nest_code p c input len cont (sc,(state,so_far)) =
  trace ("incode " ++ show state) $
  cont (sc,(state+1,'\123':so_far))  -- TODO \123 = open brace

code p c inp len cont (sc,(n,so_far)) = 
  trace "code" $
  cont (sc,(n, reverse (take len inp) ++ so_far))

unnest_code p c input len cont (sc,(1,so_far)) =
  T p (CodeT (reverse so_far)) : cont (0,(0,""))
unnest_code p c input len cont (sc,(n,so_far)) =
  cont (incode,(n-1,'\125':so_far))  -- TODO \125 = close brace

stop p c "" scs   = []
stop p c rest scs = error "lexical error" -- TODO

mk_act ac = \p _ str len cont st -> ac p len str:cont st

extract ln str = take (ln-2) (tail str)
		
do_cch ln str = chr (str2int(take (ln-1) (tail str)))

mac ln (_ : str) = take (ln-1) str

macdef ln (_ : str) = takeWhile (not.isSpace) str

esc (_ : x : _)  =
 case x of
   'a' -> '\a'
   'b' -> '\b'
   'f' -> '\f'
   'n' -> '\n'
   'r' -> '\r'
   't' -> '\t'
   'v' -> '\v'
   c   ->  c

str2int:: String -> Int
str2int = foldl (\n d-> n*10+ord d-ord '0') 0

lexer :: String -> [Token]
lexer = gscan (load_gscan stop alex) (0::Int,"")
}

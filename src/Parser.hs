module Parser (ourParser,AbsSyn) where
import ParseMonad
import AbsSyn
import Lexer

-- parser produced by Happy Version 1.14

data HappyAbsSyn 
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 (AbsSyn)
	| HappyAbsSyn5 ([(String, [([String],String,Int,Maybe String)], Maybe String)])
	| HappyAbsSyn6 ((String, [([String],String,Int,Maybe String)], Maybe String))
	| HappyAbsSyn7 ([([String],String,Int,Maybe String)])
	| HappyAbsSyn8 (([String],String,Int,Maybe String))
	| HappyAbsSyn9 (Maybe String)
	| HappyAbsSyn10 ([Directive String])
	| HappyAbsSyn11 (Directive String)
	| HappyAbsSyn13 ([(String,String)])
	| HappyAbsSyn14 ((String,String))
	| HappyAbsSyn15 ([String])

type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> m HappyAbsSyn

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65 :: () => Int -> HappyReduction (P)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37 :: () => HappyReduction (P)

action_0 (30) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (16) = happyGoto action_2
action_0 _ = happyReduce_37

action_1 (30) = happyShift action_3
action_1 (16) = happyGoto action_2
action_1 _ = happyFail

action_2 (18) = happyShift action_7
action_2 (19) = happyShift action_8
action_2 (20) = happyShift action_9
action_2 (21) = happyShift action_10
action_2 (22) = happyShift action_11
action_2 (23) = happyShift action_12
action_2 (24) = happyShift action_13
action_2 (25) = happyShift action_14
action_2 (26) = happyShift action_15
action_2 (27) = happyShift action_16
action_2 (29) = happyShift action_17
action_2 (10) = happyGoto action_5
action_2 (11) = happyGoto action_6
action_2 _ = happyFail

action_3 _ = happyReduce_36

action_4 (37) = happyAccept
action_4 _ = happyFail

action_5 (18) = happyShift action_7
action_5 (19) = happyShift action_8
action_5 (20) = happyShift action_9
action_5 (21) = happyShift action_10
action_5 (22) = happyShift action_11
action_5 (23) = happyShift action_12
action_5 (24) = happyShift action_13
action_5 (25) = happyShift action_14
action_5 (26) = happyShift action_15
action_5 (27) = happyShift action_16
action_5 (29) = happyShift action_17
action_5 (35) = happyShift action_32
action_5 (11) = happyGoto action_31
action_5 _ = happyFail

action_6 _ = happyReduce_14

action_7 (30) = happyShift action_30
action_7 _ = happyFail

action_8 (17) = happyShift action_29
action_8 (13) = happyGoto action_27
action_8 (14) = happyGoto action_28
action_8 _ = happyFail

action_9 (17) = happyShift action_26
action_9 _ = happyFail

action_10 (17) = happyShift action_25
action_10 _ = happyFail

action_11 (30) = happyShift action_24
action_11 _ = happyFail

action_12 _ = happyReduce_19

action_13 (30) = happyShift action_23
action_13 _ = happyFail

action_14 (17) = happyShift action_20
action_14 (15) = happyGoto action_22
action_14 _ = happyReduce_35

action_15 (17) = happyShift action_20
action_15 (15) = happyGoto action_21
action_15 _ = happyReduce_35

action_16 (17) = happyShift action_20
action_16 (15) = happyGoto action_19
action_16 _ = happyReduce_35

action_17 (31) = happyShift action_18
action_17 _ = happyFail

action_18 _ = happyReduce_28

action_19 _ = happyReduce_26

action_20 (17) = happyShift action_20
action_20 (15) = happyGoto action_43
action_20 _ = happyReduce_35

action_21 _ = happyReduce_27

action_22 _ = happyReduce_25

action_23 (30) = happyShift action_42
action_23 _ = happyReduce_21

action_24 (30) = happyShift action_41
action_24 _ = happyFail

action_25 (17) = happyShift action_39
action_25 (12) = happyGoto action_40
action_25 _ = happyReduce_30

action_26 (17) = happyShift action_39
action_26 (12) = happyGoto action_38
action_26 _ = happyReduce_30

action_27 _ = happyReduce_16

action_28 (17) = happyShift action_29
action_28 (13) = happyGoto action_37
action_28 (14) = happyGoto action_28
action_28 _ = happyReduce_32

action_29 (30) = happyShift action_36
action_29 _ = happyFail

action_30 _ = happyReduce_15

action_31 _ = happyReduce_13

action_32 (17) = happyShift action_35
action_32 (5) = happyGoto action_33
action_32 (6) = happyGoto action_34
action_32 _ = happyFail

action_33 (17) = happyShift action_35
action_33 (30) = happyShift action_3
action_33 (6) = happyGoto action_47
action_33 (16) = happyGoto action_48
action_33 _ = happyReduce_37

action_34 _ = happyReduce_3

action_35 (32) = happyShift action_45
action_35 (34) = happyShift action_46
action_35 _ = happyFail

action_36 _ = happyReduce_33

action_37 _ = happyReduce_31

action_38 _ = happyReduce_17

action_39 _ = happyReduce_29

action_40 _ = happyReduce_18

action_41 _ = happyReduce_20

action_42 (30) = happyShift action_44
action_42 _ = happyReduce_22

action_43 _ = happyReduce_34

action_44 (30) = happyShift action_53
action_44 _ = happyReduce_23

action_45 (17) = happyShift action_20
action_45 (7) = happyGoto action_50
action_45 (8) = happyGoto action_51
action_45 (15) = happyGoto action_52
action_45 _ = happyReduce_35

action_46 (30) = happyShift action_49
action_46 _ = happyFail

action_47 _ = happyReduce_2

action_48 _ = happyReduce_1

action_49 (17) = happyShift action_57
action_49 (32) = happyShift action_58
action_49 _ = happyFail

action_50 _ = happyReduce_6

action_51 (36) = happyShift action_56
action_51 _ = happyReduce_8

action_52 (28) = happyShift action_55
action_52 (9) = happyGoto action_54
action_52 _ = happyReduce_12

action_53 _ = happyReduce_24

action_54 (30) = happyShift action_63
action_54 _ = happyFail

action_55 (17) = happyShift action_62
action_55 _ = happyFail

action_56 (17) = happyShift action_20
action_56 (7) = happyGoto action_61
action_56 (8) = happyGoto action_51
action_56 (15) = happyGoto action_52
action_56 _ = happyReduce_35

action_57 (32) = happyShift action_60
action_57 _ = happyFail

action_58 (17) = happyShift action_20
action_58 (7) = happyGoto action_59
action_58 (8) = happyGoto action_51
action_58 (15) = happyGoto action_52
action_58 _ = happyReduce_35

action_59 _ = happyReduce_4

action_60 (17) = happyShift action_20
action_60 (7) = happyGoto action_65
action_60 (8) = happyGoto action_51
action_60 (15) = happyGoto action_52
action_60 _ = happyReduce_35

action_61 _ = happyReduce_7

action_62 _ = happyReduce_11

action_63 (33) = happyShift action_64
action_63 _ = happyReduce_10

action_64 _ = happyReduce_9

action_65 _ = happyReduce_5

happyReduce_1 = happyReduce 5 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	(HappyAbsSyn9  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AbsSyn happy_var_1 (reverse happy_var_2) (reverse happy_var_4) happy_var_5
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_2 5 happyReduction_2
happyReduction_2 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_2 : happy_var_1
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1 5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happyReduce 5 6 happyReduction_4
happyReduction_4 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInfo happy_var_1 TokId)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_1,happy_var_5,Just happy_var_3)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 ((HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInfo happy_var_1 TokId)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_1,happy_var_6,Just happy_var_3)
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3 6 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_3)
	_
	(HappyTerminal (TokenInfo happy_var_1 TokId))
	 =  HappyAbsSyn6
		 ((happy_var_1,happy_var_3,Nothing)
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3 7 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1 : happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1 7 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happyMonadReduce 4 8 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = happyThen ( \s l -> returnP (happy_var_1,happy_var_3,l,happy_var_2) s l
	) (\r -> happyReturn (HappyAbsSyn8 r))

happyReduce_10 = happyMonadReduce 3 8 happyReduction_10
happyReduction_10 ((HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = happyThen ( \s l -> returnP (happy_var_1,happy_var_3,l,happy_var_2) s l
	) (\r -> happyReturn (HappyAbsSyn8 r))

happyReduce_11 = happySpecReduce_2 9 happyReduction_11
happyReduction_11 (HappyTerminal (TokenInfo happy_var_2 TokId))
	_
	 =  HappyAbsSyn9
		 (Just happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_0 9 happyReduction_12
happyReduction_12  =  HappyAbsSyn9
		 (Nothing
	)

happyReduce_13 = happySpecReduce_2 10 happyReduction_13
happyReduction_13 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_2 : happy_var_1
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1 10 happyReduction_14
happyReduction_14 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2 11 happyReduction_15
happyReduction_15 (HappyTerminal (TokenInfo happy_var_2 TokCodeQuote))
	_
	 =  HappyAbsSyn11
		 (TokenType happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2 11 happyReduction_16
happyReduction_16 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (TokenSpec happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3 11 happyReduction_17
happyReduction_17 (HappyAbsSyn9  happy_var_3)
	(HappyTerminal (TokenInfo happy_var_2 TokId))
	_
	 =  HappyAbsSyn11
		 (TokenName happy_var_2 happy_var_3 False
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3 11 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_3)
	(HappyTerminal (TokenInfo happy_var_2 TokId))
	_
	 =  HappyAbsSyn11
		 (TokenName happy_var_2 happy_var_3 True
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1 11 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn11
		 (TokenImportedIdentity
	)

happyReduce_20 = happySpecReduce_3 11 happyReduction_20
happyReduction_20 (HappyTerminal (TokenInfo happy_var_3 TokCodeQuote))
	(HappyTerminal (TokenInfo happy_var_2 TokCodeQuote))
	_
	 =  HappyAbsSyn11
		 (TokenLexer happy_var_2 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2 11 happyReduction_21
happyReduction_21 (HappyTerminal (TokenInfo happy_var_2 TokCodeQuote))
	_
	 =  HappyAbsSyn11
		 (TokenMonad "()" happy_var_2 ">>=" "return"
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3 11 happyReduction_22
happyReduction_22 (HappyTerminal (TokenInfo happy_var_3 TokCodeQuote))
	(HappyTerminal (TokenInfo happy_var_2 TokCodeQuote))
	_
	 =  HappyAbsSyn11
		 (TokenMonad happy_var_2 happy_var_3 ">>=" "return"
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 4 11 happyReduction_23
happyReduction_23 ((HappyTerminal (TokenInfo happy_var_4 TokCodeQuote)) `HappyStk`
	(HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	(HappyTerminal (TokenInfo happy_var_2 TokCodeQuote)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (TokenMonad "()" happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 5 11 happyReduction_24
happyReduction_24 ((HappyTerminal (TokenInfo happy_var_5 TokCodeQuote)) `HappyStk`
	(HappyTerminal (TokenInfo happy_var_4 TokCodeQuote)) `HappyStk`
	(HappyTerminal (TokenInfo happy_var_3 TokCodeQuote)) `HappyStk`
	(HappyTerminal (TokenInfo happy_var_2 TokCodeQuote)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (TokenMonad happy_var_2 happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_2 11 happyReduction_25
happyReduction_25 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (TokenNonassoc happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2 11 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (TokenRight happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2 11 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (TokenLeft happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2 11 happyReduction_28
happyReduction_28 (HappyTerminal (TokenNum happy_var_2  TokNum))
	_
	 =  HappyAbsSyn11
		 (TokenExpect happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1 12 happyReduction_29
happyReduction_29 (HappyTerminal (TokenInfo happy_var_1 TokId))
	 =  HappyAbsSyn9
		 (Just happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0 12 happyReduction_30
happyReduction_30  =  HappyAbsSyn9
		 (Nothing
	)

happyReduce_31 = happySpecReduce_2 13 happyReduction_31
happyReduction_31 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1:happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1 13 happyReduction_32
happyReduction_32 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2 14 happyReduction_33
happyReduction_33 (HappyTerminal (TokenInfo happy_var_2 TokCodeQuote))
	(HappyTerminal (TokenInfo happy_var_1 TokId))
	 =  HappyAbsSyn14
		 ((happy_var_1,happy_var_2)
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2 15 happyReduction_34
happyReduction_34 (HappyAbsSyn15  happy_var_2)
	(HappyTerminal (TokenInfo happy_var_1 TokId))
	 =  HappyAbsSyn15
		 (happy_var_1 : happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_0 15 happyReduction_35
happyReduction_35  =  HappyAbsSyn15
		 ([]
	)

happyReduce_36 = happySpecReduce_1 16 happyReduction_36
happyReduction_36 (HappyTerminal (TokenInfo happy_var_1 TokCodeQuote))
	 =  HappyAbsSyn9
		 (Just happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_0 16 happyReduction_37
happyReduction_37  =  HappyAbsSyn9
		 (Nothing
	)

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 37 37 (error "reading EOF!") (HappyState action) sts stk;
	TokenInfo happy_dollar_dollar TokId -> cont 17;
	TokenKW      TokSpecId_TokenType -> cont 18;
	TokenKW      TokSpecId_Token -> cont 19;
	TokenKW      TokSpecId_Name -> cont 20;
	TokenKW      TokSpecId_Partial -> cont 21;
	TokenKW      TokSpecId_Lexer -> cont 22;
	TokenKW      TokSpecId_ImportedIdentity -> cont 23;
	TokenKW      TokSpecId_Monad -> cont 24;
	TokenKW      TokSpecId_Nonassoc -> cont 25;
	TokenKW      TokSpecId_Left -> cont 26;
	TokenKW      TokSpecId_Right -> cont 27;
	TokenKW      TokSpecId_Prec -> cont 28;
	TokenKW      TokSpecId_Expect -> cont 29;
	TokenInfo happy_dollar_dollar TokCodeQuote -> cont 30;
	TokenNum happy_dollar_dollar  TokNum -> cont 31;
	TokenKW      TokColon -> cont 32;
	TokenKW      TokSemiColon -> cont 33;
	TokenKW      TokDoubleColon -> cont 34;
	TokenKW      TokDoublePercent -> cont 35;
	TokenKW      TokBar -> cont 36;
	_ -> happyError'
	})

happyError_ tk = happyError'

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (thenP)
happyReturn :: () => a -> P a
happyReturn = (returnP)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => P a
happyError' = happyError

ourParser = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq

happyError :: P a
happyError s l = failP (show l ++ ": Parse error\n") s l
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id: Parser.hs,v 1.22 2005/01/14 14:47:18 simonmar Exp $

{-# LINE 15 "GenericTemplate.hs" #-}






















































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 154 "GenericTemplate.hs" #-}


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

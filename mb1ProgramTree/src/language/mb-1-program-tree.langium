grammar Mb1ProgramTree

entry Model:
    persons+=Person | greetings+=Greeting| mb1ProgramTree+=MB1OverallProgramTree;

Person:
    'person' name=ID;

Greeting:
    'Hello' person=[Person:ID] '!';

MB1OverallProgramTree:
	 "MB1OverallProgramTree"
     "MagicBytes:" magicBytes='CPM2'
	 property+=Property*
     subTable+=SubTable* 'END';

Property:
	"Property:" name=STRING
    "DataType:" type=Data_Type
    ("DefaultValue:" default=STRING)?
    ("Comment:" default=STRING)?;

 SubTable:
	'SubTable Name: '( subTableName=STRING)
	('Supported Version From:' type=SupportVersion)?
	 property+=Property*
	 bsTable+=BSTable?
	 property+=Property*
	 compositeTable+=SubTable*
	 'END';

BSTable:
	 'IndividualBSTable: ' bsTable=STRING;
	 
SupportVersion:
    'Base Module Type' ('BaseModuleType:' type=BaseModule_Type)
	//("Base Module Type: " type=BaseModuleType)
	"Major Version" majorVersion=INT
	"Minor Version" minorVersion=INT
;   

type DataType = 'Byte' | 'Short' | 'Int' | 'Long';
Data_Type returns DataType: 
    Byte | Short | Int | Long 
;
Byte returns string: 'byte';
Short returns string: 'short';
Int returns string: 'int';
Long returns string: 'long';
  
type BaseModuleType = 'MB1' | 'MB0' | 'MB0_1' | 'MCO';
BaseModule_Type returns BaseModuleType:
    MB1 | MB0 | MB0_1 | MC0
;
MB1 returns string: 'mB1';
MB0 returns string: 'mB0';
MB0_1 returns string: 'mB0.1';
MC0 returns string: 'mC0';

hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal INT returns number: /[0-9]+/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;

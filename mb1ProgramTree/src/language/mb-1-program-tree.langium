grammar Mb1ProgramTree

entry Model:
  mb1ProgramTree+=SubTableType*;

PropertyType:
	'Property: ' name=STRING
	'DataType:' dataType=Data_Type
    ("DefaultValue:" default=STRING)?;

 SubTableType:
	'SubTable Name: '( name=STRING)
	('Supported Version From:' type=SupportVersion)?
	 properties+=PropertyType*
	 (bsTable+=BSTable)?
	 subtables+=SubTableType*
	 'END';

BSTable:
	 'ContentType: ' contentType=STRING
	properties+=PropertyType*;
	 
SupportVersion:
    'Base Module Type' ('BaseModuleType:' type=BaseModule_Type)
	//('Base Module Type: ' type=BaseModuleType)
	'Major Version' majorVersion=INT
	'Minor Version' minorVersion=INT
;   

type NumBytes = 'One' | 'Two' | 'Three' | 'Four';
Num_Bytes returns NumBytes:
	One | Two | Three | Four;
One returns string: '1';
Two returns string: '2';
Three returns string: '3';
Four returns string: '4';

type DataType = 'Byte' | 'Short' | 'Int' | 'Long' | 'ConnectionType';
Data_Type returns DataType: 
    Byte | Short | Int | Long | ConnectionType 
;
Byte returns string: 'byte';
Short returns string: 'short';
Int returns string: 'int';
Long returns string: 'long';
ConnectionType returns string: 'connectionType';

ConnectionTypeX:
	'High Byte' highByte=Byte
	'Low Byte' lowByte=Byte
;
  
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

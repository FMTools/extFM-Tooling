@SuppressWarnings(tokenOverlapping)
SYNTAXDEF rbactext // role based access control for feature models
FOR <http://www.tudresden.de/rbac>
START AccessControlModel

OPTIONS {
	additionalDependencies = "org.js.model.feature";
	reloadGeneratorModel = "true";
	generateCodeFromGeneratorModel = "true";
	disableLaunchSupport = "true";
	disableNewProjectWizard = "true";

 	srcFolder = "src/main/java";
	srcGenFolder = "src/gen/java";
	
	uiSrcFolder = "src/main/java";
	uiSrcGenFolder = "src/gen/java";
}

TOKENS {
	DEFINE S_DESELECT $'deselect'$;
	DEFINE S_SELECT $'select'$;
	DEFINE COMMA $(','|';')$;
	DEFINE COMMENT $'//'(~('\n'|'\r'|'\uffff'))* $ ;
}

TOKENSTYLES {
	"#" COLOR #800055, BOLD;
	"COMMENT" COLOR #AAAAAA;
}	
	
	RULES {
	// syntax definition for class 'StartMetaClass'
	AccessControlModel   ::= "access control" #1 
									"references" #1 (featureModels['<','>'])+ !0
									//("configuration operations" #1 !0 configurationOperations*)? !0
									roles* !0 
									subjects*; 
	
	//Stage ::= type[Declaration : "declaration", Integration : "integration", Specialization : "specialization", Separation : "separation"] 
	//		#1 "stage" ("roles" "{" roles[IDENTIFIER]+ "}")?;
	
	Role ::= "role" #1 name['"','"']? #1 id['<','>'] !0 
			("{" allowedConfigOperations*  allowedEngineeringOperations* "}" )? ;


	// syntax definition for engineering operations
	CreateFeatureModel ::= "$createFM";
	

	// syntax definition for configuration operations
	FeatureConfiguration ::= #4 feature[] ":" select[S_SELECT]? deselect[S_DESELECT]? ;
	AttributeConfiguration ::= #4 feature[] "#" attribute[] 
			(( ":" select[S_SELECT]? deselect[S_DESELECT]?)
			 | ("(" valueConfigurations+ ")")) ;

	DomainValueConfiguration ::=  (value['"','"'] ":" select[S_SELECT]? deselect[S_DESELECT]?);
	//DomainValueConfiguration ::=  (value['"','"'] ":" select[S_SELECT]? deselect[S_DESELECT]?) | (_[COMMA] value['"','"'] ":" select[S_SELECT]? deselect[S_DESELECT]?);


	Subject ::= "subject" #1 name['"','"'] #1 id['<','>'] !0 
			("{" roles[]+ "}")?;


}

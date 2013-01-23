grammar Rbactext;

options {
	superClass = RbactextANTLRParserBase;
	backtrack = true;
	memoize = true;
}

@lexer::header {
	package org.js.model.rbac.resource.rbactext.mopp;
}

@lexer::members {
	public java.util.List<org.antlr.runtime3_4_0.RecognitionException> lexerExceptions  = new java.util.ArrayList<org.antlr.runtime3_4_0.RecognitionException>();
	public java.util.List<Integer> lexerExceptionsPosition = new java.util.ArrayList<Integer>();
	
	public void reportError(org.antlr.runtime3_4_0.RecognitionException e) {
		lexerExceptions.add(e);
		lexerExceptionsPosition.add(((org.antlr.runtime3_4_0.ANTLRStringStream) input).index());
	}
}
@header{
	package org.js.model.rbac.resource.rbactext.mopp;
}

@members{
	private org.js.model.rbac.resource.rbactext.IRbactextTokenResolverFactory tokenResolverFactory = new org.js.model.rbac.resource.rbactext.mopp.RbactextTokenResolverFactory();
	
	/**
	 * the index of the last token that was handled by collectHiddenTokens()
	 */
	private int lastPosition;
	
	/**
	 * A flag that indicates whether the parser should remember all expected elements.
	 * This flag is set to true when using the parse for code completion. Otherwise it
	 * is set to false.
	 */
	private boolean rememberExpectedElements = false;
	
	private Object parseToIndexTypeObject;
	private int lastTokenIndex = 0;
	
	/**
	 * A list of expected elements the were collected while parsing the input stream.
	 * This list is only filled if <code>rememberExpectedElements</code> is set to
	 * true.
	 */
	private java.util.List<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal> expectedElements = new java.util.ArrayList<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal>();
	
	private int mismatchedTokenRecoveryTries = 0;
	/**
	 * A helper list to allow a lexer to pass errors to its parser
	 */
	protected java.util.List<org.antlr.runtime3_4_0.RecognitionException> lexerExceptions = java.util.Collections.synchronizedList(new java.util.ArrayList<org.antlr.runtime3_4_0.RecognitionException>());
	
	/**
	 * Another helper list to allow a lexer to pass positions of errors to its parser
	 */
	protected java.util.List<Integer> lexerExceptionsPosition = java.util.Collections.synchronizedList(new java.util.ArrayList<Integer>());
	
	/**
	 * A stack for incomplete objects. This stack is used filled when the parser is
	 * used for code completion. Whenever the parser starts to read an object it is
	 * pushed on the stack. Once the element was parser completely it is popped from
	 * the stack.
	 */
	java.util.List<org.eclipse.emf.ecore.EObject> incompleteObjects = new java.util.ArrayList<org.eclipse.emf.ecore.EObject>();
	
	private int stopIncludingHiddenTokens;
	private int stopExcludingHiddenTokens;
	private int tokenIndexOfLastCompleteElement;
	
	private int expectedElementsIndexOfLastCompleteElement;
	
	/**
	 * The offset indicating the cursor position when the parser is used for code
	 * completion by calling parseToExpectedElements().
	 */
	private int cursorOffset;
	
	/**
	 * The offset of the first hidden token of the last expected element. This offset
	 * is used to discard expected elements, which are not needed for code completion.
	 */
	private int lastStartIncludingHidden;
	
	protected void addErrorToResource(final String errorMessage, final int column, final int line, final int startIndex, final int stopIndex) {
		postParseCommands.add(new org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>() {
			public boolean execute(org.js.model.rbac.resource.rbactext.IRbactextTextResource resource) {
				if (resource == null) {
					// the resource can be null if the parser is used for code completion
					return true;
				}
				resource.addProblem(new org.js.model.rbac.resource.rbactext.IRbactextProblem() {
					public org.js.model.rbac.resource.rbactext.RbactextEProblemSeverity getSeverity() {
						return org.js.model.rbac.resource.rbactext.RbactextEProblemSeverity.ERROR;
					}
					public org.js.model.rbac.resource.rbactext.RbactextEProblemType getType() {
						return org.js.model.rbac.resource.rbactext.RbactextEProblemType.SYNTAX_ERROR;
					}
					public String getMessage() {
						return errorMessage;
					}
					public java.util.Collection<org.js.model.rbac.resource.rbactext.IRbactextQuickFix> getQuickFixes() {
						return null;
					}
				}, column, line, startIndex, stopIndex);
				return true;
			}
		});
	}
	
	public void addExpectedElement(org.eclipse.emf.ecore.EClass eClass, int[] ids) {
		if (!this.rememberExpectedElements) {
			return;
		}
		int terminalID = ids[0];
		int followSetID = ids[1];
		org.js.model.rbac.resource.rbactext.IRbactextExpectedElement terminal = org.js.model.rbac.resource.rbactext.grammar.RbactextFollowSetProvider.TERMINALS[terminalID];
		org.js.model.rbac.resource.rbactext.mopp.RbactextContainedFeature[] containmentFeatures = new org.js.model.rbac.resource.rbactext.mopp.RbactextContainedFeature[ids.length - 2];
		for (int i = 2; i < ids.length; i++) {
			containmentFeatures[i - 2] = org.js.model.rbac.resource.rbactext.grammar.RbactextFollowSetProvider.LINKS[ids[i]];
		}
		org.js.model.rbac.resource.rbactext.grammar.RbactextContainmentTrace containmentTrace = new org.js.model.rbac.resource.rbactext.grammar.RbactextContainmentTrace(eClass, containmentFeatures);
		org.eclipse.emf.ecore.EObject container = getLastIncompleteElement();
		org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal expectedElement = new org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal(container, terminal, followSetID, containmentTrace);
		setPosition(expectedElement, input.index());
		int startIncludingHiddenTokens = expectedElement.getStartIncludingHiddenTokens();
		if (lastStartIncludingHidden >= 0 && lastStartIncludingHidden < startIncludingHiddenTokens && cursorOffset > startIncludingHiddenTokens) {
			// clear list of expected elements
			this.expectedElements.clear();
			this.expectedElementsIndexOfLastCompleteElement = 0;
		}
		lastStartIncludingHidden = startIncludingHiddenTokens;
		this.expectedElements.add(expectedElement);
	}
	
	protected void collectHiddenTokens(org.eclipse.emf.ecore.EObject element) {
	}
	
	protected void copyLocalizationInfos(final org.eclipse.emf.ecore.EObject source, final org.eclipse.emf.ecore.EObject target) {
		if (disableLocationMap) {
			return;
		}
		postParseCommands.add(new org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>() {
			public boolean execute(org.js.model.rbac.resource.rbactext.IRbactextTextResource resource) {
				org.js.model.rbac.resource.rbactext.IRbactextLocationMap locationMap = resource.getLocationMap();
				if (locationMap == null) {
					// the locationMap can be null if the parser is used for code completion
					return true;
				}
				locationMap.setCharStart(target, locationMap.getCharStart(source));
				locationMap.setCharEnd(target, locationMap.getCharEnd(source));
				locationMap.setColumn(target, locationMap.getColumn(source));
				locationMap.setLine(target, locationMap.getLine(source));
				return true;
			}
		});
	}
	
	protected void copyLocalizationInfos(final org.antlr.runtime3_4_0.CommonToken source, final org.eclipse.emf.ecore.EObject target) {
		if (disableLocationMap) {
			return;
		}
		postParseCommands.add(new org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>() {
			public boolean execute(org.js.model.rbac.resource.rbactext.IRbactextTextResource resource) {
				org.js.model.rbac.resource.rbactext.IRbactextLocationMap locationMap = resource.getLocationMap();
				if (locationMap == null) {
					// the locationMap can be null if the parser is used for code completion
					return true;
				}
				if (source == null) {
					return true;
				}
				locationMap.setCharStart(target, source.getStartIndex());
				locationMap.setCharEnd(target, source.getStopIndex());
				locationMap.setColumn(target, source.getCharPositionInLine());
				locationMap.setLine(target, source.getLine());
				return true;
			}
		});
	}
	
	/**
	 * Sets the end character index and the last line for the given object in the
	 * location map.
	 */
	protected void setLocalizationEnd(java.util.Collection<org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>> postParseCommands , final org.eclipse.emf.ecore.EObject object, final int endChar, final int endLine) {
		if (disableLocationMap) {
			return;
		}
		postParseCommands.add(new org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>() {
			public boolean execute(org.js.model.rbac.resource.rbactext.IRbactextTextResource resource) {
				org.js.model.rbac.resource.rbactext.IRbactextLocationMap locationMap = resource.getLocationMap();
				if (locationMap == null) {
					// the locationMap can be null if the parser is used for code completion
					return true;
				}
				locationMap.setCharEnd(object, endChar);
				locationMap.setLine(object, endLine);
				return true;
			}
		});
	}
	
	public org.js.model.rbac.resource.rbactext.IRbactextTextParser createInstance(java.io.InputStream actualInputStream, String encoding) {
		try {
			if (encoding == null) {
				return new RbactextParser(new org.antlr.runtime3_4_0.CommonTokenStream(new RbactextLexer(new org.antlr.runtime3_4_0.ANTLRInputStream(actualInputStream))));
			} else {
				return new RbactextParser(new org.antlr.runtime3_4_0.CommonTokenStream(new RbactextLexer(new org.antlr.runtime3_4_0.ANTLRInputStream(actualInputStream, encoding))));
			}
		} catch (java.io.IOException e) {
			new org.js.model.rbac.resource.rbactext.util.RbactextRuntimeUtil().logError("Error while creating parser.", e);
			return null;
		}
	}
	
	/**
	 * This default constructor is only used to call createInstance() on it.
	 */
	public RbactextParser() {
		super(null);
	}
	
	protected org.eclipse.emf.ecore.EObject doParse() throws org.antlr.runtime3_4_0.RecognitionException {
		this.lastPosition = 0;
		// required because the lexer class can not be subclassed
		((RbactextLexer) getTokenStream().getTokenSource()).lexerExceptions = lexerExceptions;
		((RbactextLexer) getTokenStream().getTokenSource()).lexerExceptionsPosition = lexerExceptionsPosition;
		Object typeObject = getTypeObject();
		if (typeObject == null) {
			return start();
		} else if (typeObject instanceof org.eclipse.emf.ecore.EClass) {
			org.eclipse.emf.ecore.EClass type = (org.eclipse.emf.ecore.EClass) typeObject;
			if (type.getInstanceClass() == org.js.model.rbac.AccessControlModel.class) {
				return parse_org_js_model_rbac_AccessControlModel();
			}
			if (type.getInstanceClass() == org.js.model.rbac.Role.class) {
				return parse_org_js_model_rbac_Role();
			}
			if (type.getInstanceClass() == org.js.model.rbac.CreateFeatureModel.class) {
				return parse_org_js_model_rbac_CreateFeatureModel();
			}
			if (type.getInstanceClass() == org.js.model.rbac.FeatureConfiguration.class) {
				return parse_org_js_model_rbac_FeatureConfiguration();
			}
			if (type.getInstanceClass() == org.js.model.rbac.AttributeConfiguration.class) {
				return parse_org_js_model_rbac_AttributeConfiguration();
			}
			if (type.getInstanceClass() == org.js.model.rbac.DomainValueConfiguration.class) {
				return parse_org_js_model_rbac_DomainValueConfiguration();
			}
			if (type.getInstanceClass() == org.js.model.rbac.Subject.class) {
				return parse_org_js_model_rbac_Subject();
			}
		}
		throw new org.js.model.rbac.resource.rbactext.mopp.RbactextUnexpectedContentTypeException(typeObject);
	}
	
	public int getMismatchedTokenRecoveryTries() {
		return mismatchedTokenRecoveryTries;
	}
	
	public Object getMissingSymbol(org.antlr.runtime3_4_0.IntStream arg0, org.antlr.runtime3_4_0.RecognitionException arg1, int arg2, org.antlr.runtime3_4_0.BitSet arg3) {
		mismatchedTokenRecoveryTries++;
		return super.getMissingSymbol(arg0, arg1, arg2, arg3);
	}
	
	public Object getParseToIndexTypeObject() {
		return parseToIndexTypeObject;
	}
	
	protected Object getTypeObject() {
		Object typeObject = getParseToIndexTypeObject();
		if (typeObject != null) {
			return typeObject;
		}
		java.util.Map<?,?> options = getOptions();
		if (options != null) {
			typeObject = options.get(org.js.model.rbac.resource.rbactext.IRbactextOptions.RESOURCE_CONTENT_TYPE);
		}
		return typeObject;
	}
	
	/**
	 * Implementation that calls {@link #doParse()} and handles the thrown
	 * RecognitionExceptions.
	 */
	public org.js.model.rbac.resource.rbactext.IRbactextParseResult parse() {
		terminateParsing = false;
		postParseCommands = new java.util.ArrayList<org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource>>();
		org.js.model.rbac.resource.rbactext.mopp.RbactextParseResult parseResult = new org.js.model.rbac.resource.rbactext.mopp.RbactextParseResult();
		try {
			org.eclipse.emf.ecore.EObject result =  doParse();
			if (lexerExceptions.isEmpty()) {
				parseResult.setRoot(result);
			}
		} catch (org.antlr.runtime3_4_0.RecognitionException re) {
			reportError(re);
		} catch (java.lang.IllegalArgumentException iae) {
			if ("The 'no null' constraint is violated".equals(iae.getMessage())) {
				// can be caused if a null is set on EMF models where not allowed. this will just
				// happen if other errors occurred before
			} else {
				iae.printStackTrace();
			}
		}
		for (org.antlr.runtime3_4_0.RecognitionException re : lexerExceptions) {
			reportLexicalError(re);
		}
		parseResult.getPostParseCommands().addAll(postParseCommands);
		return parseResult;
	}
	
	public java.util.List<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal> parseToExpectedElements(org.eclipse.emf.ecore.EClass type, org.js.model.rbac.resource.rbactext.IRbactextTextResource dummyResource, int cursorOffset) {
		this.rememberExpectedElements = true;
		this.parseToIndexTypeObject = type;
		this.cursorOffset = cursorOffset;
		this.lastStartIncludingHidden = -1;
		final org.antlr.runtime3_4_0.CommonTokenStream tokenStream = (org.antlr.runtime3_4_0.CommonTokenStream) getTokenStream();
		org.js.model.rbac.resource.rbactext.IRbactextParseResult result = parse();
		for (org.eclipse.emf.ecore.EObject incompleteObject : incompleteObjects) {
			org.antlr.runtime3_4_0.Lexer lexer = (org.antlr.runtime3_4_0.Lexer) tokenStream.getTokenSource();
			int endChar = lexer.getCharIndex();
			int endLine = lexer.getLine();
			setLocalizationEnd(result.getPostParseCommands(), incompleteObject, endChar, endLine);
		}
		if (result != null) {
			org.eclipse.emf.ecore.EObject root = result.getRoot();
			if (root != null) {
				dummyResource.getContentsInternal().add(root);
			}
			for (org.js.model.rbac.resource.rbactext.IRbactextCommand<org.js.model.rbac.resource.rbactext.IRbactextTextResource> command : result.getPostParseCommands()) {
				command.execute(dummyResource);
			}
		}
		// remove all expected elements that were added after the last complete element
		expectedElements = expectedElements.subList(0, expectedElementsIndexOfLastCompleteElement + 1);
		int lastFollowSetID = expectedElements.get(expectedElementsIndexOfLastCompleteElement).getFollowSetID();
		java.util.Set<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal> currentFollowSet = new java.util.LinkedHashSet<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal>();
		java.util.List<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal> newFollowSet = new java.util.ArrayList<org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal>();
		for (int i = expectedElementsIndexOfLastCompleteElement; i >= 0; i--) {
			org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal expectedElementI = expectedElements.get(i);
			if (expectedElementI.getFollowSetID() == lastFollowSetID) {
				currentFollowSet.add(expectedElementI);
			} else {
				break;
			}
		}
		int followSetID = 59;
		int i;
		for (i = tokenIndexOfLastCompleteElement; i < tokenStream.size(); i++) {
			org.antlr.runtime3_4_0.CommonToken nextToken = (org.antlr.runtime3_4_0.CommonToken) tokenStream.get(i);
			if (nextToken.getType() < 0) {
				break;
			}
			if (nextToken.getChannel() == 99) {
				// hidden tokens do not reduce the follow set
			} else {
				// now that we have found the next visible token the position for that expected
				// terminals can be set
				for (org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal nextFollow : newFollowSet) {
					lastTokenIndex = 0;
					setPosition(nextFollow, i);
				}
				newFollowSet.clear();
				// normal tokens do reduce the follow set - only elements that match the token are
				// kept
				for (org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal nextFollow : currentFollowSet) {
					if (nextFollow.getTerminal().getTokenNames().contains(getTokenNames()[nextToken.getType()])) {
						// keep this one - it matches
						java.util.Collection<org.js.model.rbac.resource.rbactext.util.RbactextPair<org.js.model.rbac.resource.rbactext.IRbactextExpectedElement, org.js.model.rbac.resource.rbactext.mopp.RbactextContainedFeature[]>> newFollowers = nextFollow.getTerminal().getFollowers();
						for (org.js.model.rbac.resource.rbactext.util.RbactextPair<org.js.model.rbac.resource.rbactext.IRbactextExpectedElement, org.js.model.rbac.resource.rbactext.mopp.RbactextContainedFeature[]> newFollowerPair : newFollowers) {
							org.js.model.rbac.resource.rbactext.IRbactextExpectedElement newFollower = newFollowerPair.getLeft();
							org.eclipse.emf.ecore.EObject container = getLastIncompleteElement();
							org.js.model.rbac.resource.rbactext.grammar.RbactextContainmentTrace containmentTrace = new org.js.model.rbac.resource.rbactext.grammar.RbactextContainmentTrace(null, newFollowerPair.getRight());
							org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal newFollowTerminal = new org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal(container, newFollower, followSetID, containmentTrace);
							newFollowSet.add(newFollowTerminal);
							expectedElements.add(newFollowTerminal);
						}
					}
				}
				currentFollowSet.clear();
				currentFollowSet.addAll(newFollowSet);
			}
			followSetID++;
		}
		// after the last token in the stream we must set the position for the elements
		// that were added during the last iteration of the loop
		for (org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal nextFollow : newFollowSet) {
			lastTokenIndex = 0;
			setPosition(nextFollow, i);
		}
		return this.expectedElements;
	}
	
	public void setPosition(org.js.model.rbac.resource.rbactext.mopp.RbactextExpectedTerminal expectedElement, int tokenIndex) {
		int currentIndex = Math.max(0, tokenIndex);
		for (int index = lastTokenIndex; index < currentIndex; index++) {
			if (index >= input.size()) {
				break;
			}
			org.antlr.runtime3_4_0.CommonToken tokenAtIndex = (org.antlr.runtime3_4_0.CommonToken) input.get(index);
			stopIncludingHiddenTokens = tokenAtIndex.getStopIndex() + 1;
			if (tokenAtIndex.getChannel() != 99 && !anonymousTokens.contains(tokenAtIndex)) {
				stopExcludingHiddenTokens = tokenAtIndex.getStopIndex() + 1;
			}
		}
		lastTokenIndex = Math.max(0, currentIndex);
		expectedElement.setPosition(stopExcludingHiddenTokens, stopIncludingHiddenTokens);
	}
	
	public Object recoverFromMismatchedToken(org.antlr.runtime3_4_0.IntStream input, int ttype, org.antlr.runtime3_4_0.BitSet follow) throws org.antlr.runtime3_4_0.RecognitionException {
		if (!rememberExpectedElements) {
			return super.recoverFromMismatchedToken(input, ttype, follow);
		} else {
			return null;
		}
	}
	
	/**
	 * Translates errors thrown by the parser into human readable messages.
	 */
	public void reportError(final org.antlr.runtime3_4_0.RecognitionException e)  {
		String message = e.getMessage();
		if (e instanceof org.antlr.runtime3_4_0.MismatchedTokenException) {
			org.antlr.runtime3_4_0.MismatchedTokenException mte = (org.antlr.runtime3_4_0.MismatchedTokenException) e;
			String expectedTokenName = formatTokenName(mte.expecting);
			String actualTokenName = formatTokenName(e.token.getType());
			message = "Syntax error on token \"" + e.token.getText() + " (" + actualTokenName + ")\", \"" + expectedTokenName + "\" expected";
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedTreeNodeException) {
			org.antlr.runtime3_4_0.MismatchedTreeNodeException mtne = (org.antlr.runtime3_4_0.MismatchedTreeNodeException) e;
			String expectedTokenName = formatTokenName(mtne.expecting);
			message = "mismatched tree node: " + "xxx" + "; tokenName " + expectedTokenName;
		} else if (e instanceof org.antlr.runtime3_4_0.NoViableAltException) {
			message = "Syntax error on token \"" + e.token.getText() + "\", check following tokens";
		} else if (e instanceof org.antlr.runtime3_4_0.EarlyExitException) {
			message = "Syntax error on token \"" + e.token.getText() + "\", delete this token";
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedSetException) {
			org.antlr.runtime3_4_0.MismatchedSetException mse = (org.antlr.runtime3_4_0.MismatchedSetException) e;
			message = "mismatched token: " + e.token + "; expecting set " + mse.expecting;
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedNotSetException) {
			org.antlr.runtime3_4_0.MismatchedNotSetException mse = (org.antlr.runtime3_4_0.MismatchedNotSetException) e;
			message = "mismatched token: " +  e.token + "; expecting set " + mse.expecting;
		} else if (e instanceof org.antlr.runtime3_4_0.FailedPredicateException) {
			org.antlr.runtime3_4_0.FailedPredicateException fpe = (org.antlr.runtime3_4_0.FailedPredicateException) e;
			message = "rule " + fpe.ruleName + " failed predicate: {" +  fpe.predicateText + "}?";
		}
		// the resource may be null if the parser is used for code completion
		final String finalMessage = message;
		if (e.token instanceof org.antlr.runtime3_4_0.CommonToken) {
			final org.antlr.runtime3_4_0.CommonToken ct = (org.antlr.runtime3_4_0.CommonToken) e.token;
			addErrorToResource(finalMessage, ct.getCharPositionInLine(), ct.getLine(), ct.getStartIndex(), ct.getStopIndex());
		} else {
			addErrorToResource(finalMessage, e.token.getCharPositionInLine(), e.token.getLine(), 1, 5);
		}
	}
	
	/**
	 * Translates errors thrown by the lexer into human readable messages.
	 */
	public void reportLexicalError(final org.antlr.runtime3_4_0.RecognitionException e)  {
		String message = "";
		if (e instanceof org.antlr.runtime3_4_0.MismatchedTokenException) {
			org.antlr.runtime3_4_0.MismatchedTokenException mte = (org.antlr.runtime3_4_0.MismatchedTokenException) e;
			message = "Syntax error on token \"" + ((char) e.c) + "\", \"" + (char) mte.expecting + "\" expected";
		} else if (e instanceof org.antlr.runtime3_4_0.NoViableAltException) {
			message = "Syntax error on token \"" + ((char) e.c) + "\", delete this token";
		} else if (e instanceof org.antlr.runtime3_4_0.EarlyExitException) {
			org.antlr.runtime3_4_0.EarlyExitException eee = (org.antlr.runtime3_4_0.EarlyExitException) e;
			message = "required (...)+ loop (decision=" + eee.decisionNumber + ") did not match anything; on line " + e.line + ":" + e.charPositionInLine + " char=" + ((char) e.c) + "'";
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedSetException) {
			org.antlr.runtime3_4_0.MismatchedSetException mse = (org.antlr.runtime3_4_0.MismatchedSetException) e;
			message = "mismatched char: '" + ((char) e.c) + "' on line " + e.line + ":" + e.charPositionInLine + "; expecting set " + mse.expecting;
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedNotSetException) {
			org.antlr.runtime3_4_0.MismatchedNotSetException mse = (org.antlr.runtime3_4_0.MismatchedNotSetException) e;
			message = "mismatched char: '" + ((char) e.c) + "' on line " + e.line + ":" + e.charPositionInLine + "; expecting set " + mse.expecting;
		} else if (e instanceof org.antlr.runtime3_4_0.MismatchedRangeException) {
			org.antlr.runtime3_4_0.MismatchedRangeException mre = (org.antlr.runtime3_4_0.MismatchedRangeException) e;
			message = "mismatched char: '" + ((char) e.c) + "' on line " + e.line + ":" + e.charPositionInLine + "; expecting set '" + (char) mre.a + "'..'" + (char) mre.b + "'";
		} else if (e instanceof org.antlr.runtime3_4_0.FailedPredicateException) {
			org.antlr.runtime3_4_0.FailedPredicateException fpe = (org.antlr.runtime3_4_0.FailedPredicateException) e;
			message = "rule " + fpe.ruleName + " failed predicate: {" + fpe.predicateText + "}?";
		}
		addErrorToResource(message, e.charPositionInLine, e.line, lexerExceptionsPosition.get(lexerExceptions.indexOf(e)), lexerExceptionsPosition.get(lexerExceptions.indexOf(e)));
	}
	
	private void startIncompleteElement(Object object) {
		if (object instanceof org.eclipse.emf.ecore.EObject) {
			this.incompleteObjects.add((org.eclipse.emf.ecore.EObject) object);
		}
	}
	
	private void completedElement(Object object, boolean isContainment) {
		if (isContainment && !this.incompleteObjects.isEmpty()) {
			boolean exists = this.incompleteObjects.remove(object);
			if (!exists) {
			}
		}
		if (object instanceof org.eclipse.emf.ecore.EObject) {
			this.tokenIndexOfLastCompleteElement = getTokenStream().index();
			this.expectedElementsIndexOfLastCompleteElement = expectedElements.size() - 1;
		}
	}
	
	private org.eclipse.emf.ecore.EObject getLastIncompleteElement() {
		if (incompleteObjects.isEmpty()) {
			return null;
		}
		return incompleteObjects.get(incompleteObjects.size() - 1);
	}
	
}

start returns [ org.eclipse.emf.ecore.EObject element = null]
:
	{
		// follow set for start rule(s)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[0]);
		expectedElementsIndexOfLastCompleteElement = 0;
	}
	(
		c0 = parse_org_js_model_rbac_AccessControlModel{ element = c0; }
	)
	EOF	{
		retrieveLayoutInformation(element, null, null, false);
	}
	
;

parse_org_js_model_rbac_AccessControlModel returns [org.js.model.rbac.AccessControlModel element = null]
@init{
}
:
	a0 = 'access control' {
		if (element == null) {
			element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
			startIncompleteElement(element);
		}
		collectHiddenTokens(element);
		retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_0, null, true);
		copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a0, element);
	}
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[1]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[2]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[3]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[4]);
	}
	
	(
		(
			a1 = 'on' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_2_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a1, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[5]);
			}
			
			(
				a2 = QUOTED_60_62				
				{
					if (terminateParsing) {
						throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
					}
					if (element == null) {
						element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
						startIncompleteElement(element);
					}
					if (a2 != null) {
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
						tokenResolver.setOptions(getOptions());
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
						tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS), result);
						Object resolvedObject = result.getResolvedToken();
						if (resolvedObject == null) {
							addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
						}
						String resolved = (String) resolvedObject;
						org.js.model.feature.FeatureModel proxy = org.js.model.feature.FeatureFactory.eINSTANCE.createFeatureModel();
						collectHiddenTokens(element);
						registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.AccessControlModel, org.js.model.feature.FeatureModel>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getAccessControlModelFeatureModelsReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS), resolved, proxy);
						if (proxy != null) {
							Object value = proxy;
							addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS, value);
							completedElement(value, false);
						}
						collectHiddenTokens(element);
						retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_2_0_0_2, proxy, true);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, proxy);
					}
				}
			)
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[6]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[7]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[8]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[9]);
			}
			
			(
				(
					(
						a3 = COMMA						
					)
					{
						anonymousTokens.add((org.antlr.runtime3_4_0.CommonToken) a3);
					}
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[10]);
					}
					
					(
						a4 = QUOTED_60_62						
						{
							if (terminateParsing) {
								throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
							}
							if (element == null) {
								element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
								startIncompleteElement(element);
							}
							if (a4 != null) {
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
								tokenResolver.setOptions(getOptions());
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
								tokenResolver.resolve(a4.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS), result);
								Object resolvedObject = result.getResolvedToken();
								if (resolvedObject == null) {
									addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a4).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStopIndex());
								}
								String resolved = (String) resolvedObject;
								org.js.model.feature.FeatureModel proxy = org.js.model.feature.FeatureFactory.eINSTANCE.createFeatureModel();
								collectHiddenTokens(element);
								registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.AccessControlModel, org.js.model.feature.FeatureModel>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getAccessControlModelFeatureModelsReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS), resolved, proxy);
								if (proxy != null) {
									Object value = proxy;
									addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__FEATURE_MODELS, value);
									completedElement(value, false);
								}
								collectHiddenTokens(element);
								retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_2_0_0_3_0_0_1, proxy, true);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, element);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, proxy);
							}
						}
					)
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[11]);
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[12]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[13]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[14]);
					}
					
				)
				
			)*			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[15]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[16]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[17]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[18]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[19]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[20]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[21]);
	}
	
	(
		(
			a5 = 'references' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_4_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a5, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[22]);
			}
			
			(
				a6 = QUOTED_60_62				
				{
					if (terminateParsing) {
						throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
					}
					if (element == null) {
						element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
						startIncompleteElement(element);
					}
					if (a6 != null) {
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
						tokenResolver.setOptions(getOptions());
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
						tokenResolver.resolve(a6.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS), result);
						Object resolvedObject = result.getResolvedToken();
						if (resolvedObject == null) {
							addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a6).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a6).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a6).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a6).getStopIndex());
						}
						String resolved = (String) resolvedObject;
						org.js.model.rbac.AccessControlModel proxy = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
						collectHiddenTokens(element);
						registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.AccessControlModel, org.js.model.rbac.AccessControlModel>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getAccessControlModelAccessControlModelsReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS), resolved, proxy);
						if (proxy != null) {
							Object value = proxy;
							addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS, value);
							completedElement(value, false);
						}
						collectHiddenTokens(element);
						retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_4_0_0_2, proxy, true);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a6, element);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a6, proxy);
					}
				}
			)
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[23]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[24]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[25]);
			}
			
			(
				(
					(
						a7 = COMMA						
					)
					{
						anonymousTokens.add((org.antlr.runtime3_4_0.CommonToken) a7);
					}
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[26]);
					}
					
					(
						a8 = QUOTED_60_62						
						{
							if (terminateParsing) {
								throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
							}
							if (element == null) {
								element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
								startIncompleteElement(element);
							}
							if (a8 != null) {
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
								tokenResolver.setOptions(getOptions());
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
								tokenResolver.resolve(a8.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS), result);
								Object resolvedObject = result.getResolvedToken();
								if (resolvedObject == null) {
									addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a8).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a8).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a8).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a8).getStopIndex());
								}
								String resolved = (String) resolvedObject;
								org.js.model.rbac.AccessControlModel proxy = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
								collectHiddenTokens(element);
								registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.AccessControlModel, org.js.model.rbac.AccessControlModel>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getAccessControlModelAccessControlModelsReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS), resolved, proxy);
								if (proxy != null) {
									Object value = proxy;
									addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ACCESS_CONTROL_MODELS, value);
									completedElement(value, false);
								}
								collectHiddenTokens(element);
								retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_4_0_0_3_0_0_1, proxy, true);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a8, element);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a8, proxy);
							}
						}
					)
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[27]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[28]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[29]);
					}
					
				)
				
			)*			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[30]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[31]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[32]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[33]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[34]);
	}
	
	(
		(
			a9_0 = parse_org_js_model_rbac_Role			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
					startIncompleteElement(element);
				}
				if (a9_0 != null) {
					if (a9_0 != null) {
						Object value = a9_0;
						addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__ROLES, value);
						completedElement(value, true);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_6, a9_0, true);
					copyLocalizationInfos(a9_0, element);
				}
			}
		)
		
	)*	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[35]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[36]);
	}
	
	(
		(
			a10_0 = parse_org_js_model_rbac_Subject			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAccessControlModel();
					startIncompleteElement(element);
				}
				if (a10_0 != null) {
					if (a10_0 != null) {
						Object value = a10_0;
						addObjectToList(element, org.js.model.rbac.RbacPackage.ACCESS_CONTROL_MODEL__SUBJECTS, value);
						completedElement(value, true);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_0_0_0_8, a10_0, true);
					copyLocalizationInfos(a10_0, element);
				}
			}
		)
		
	)*	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[37]);
	}
	
;

parse_org_js_model_rbac_Role returns [org.js.model.rbac.Role element = null]
@init{
}
:
	a0 = 'role' {
		if (element == null) {
			element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
			startIncompleteElement(element);
		}
		collectHiddenTokens(element);
		retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_0, null, true);
		copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a0, element);
	}
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[38]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[39]);
	}
	
	(
		(
			a1 = QUOTED_34_34			
			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
					startIncompleteElement(element);
				}
				if (a1 != null) {
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_34_34");
					tokenResolver.setOptions(getOptions());
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
					tokenResolver.resolve(a1.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__NAME), result);
					Object resolvedObject = result.getResolvedToken();
					if (resolvedObject == null) {
						addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a1).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a1).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a1).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a1).getStopIndex());
					}
					java.lang.String resolved = (java.lang.String) resolvedObject;
					if (resolved != null) {
						Object value = resolved;
						element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__NAME), value);
						completedElement(value, false);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_2, resolved, true);
					copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a1, element);
				}
			}
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[40]);
	}
	
	(
		a2 = QUOTED_60_62		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
				startIncompleteElement(element);
			}
			if (a2 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__ID), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
				}
				java.lang.String resolved = (java.lang.String) resolvedObject;
				if (resolved != null) {
					Object value = resolved;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__ID), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_4, resolved, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[41]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[42]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[43]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[44]);
	}
	
	(
		(
			a3 = 'extends' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_5_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a3, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[45]);
			}
			
			(
				(
					a4 = TEXT					
					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
							startIncompleteElement(element);
						}
						if (a4 != null) {
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
							tokenResolver.setOptions(getOptions());
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
							tokenResolver.resolve(a4.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES), result);
							Object resolvedObject = result.getResolvedToken();
							if (resolvedObject == null) {
								addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a4).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStopIndex());
							}
							String resolved = (String) resolvedObject;
							org.js.model.rbac.Role proxy = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
							collectHiddenTokens(element);
							registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.Role, org.js.model.rbac.Role>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getRoleParentRolesReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES), resolved, proxy);
							if (proxy != null) {
								Object value = proxy;
								addObjectToList(element, org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES, value);
								completedElement(value, false);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_5_0_0_1_0_0_0, proxy, true);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, element);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, proxy);
						}
					}
				)
				{
					// expected elements (follow set)
					addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[46]);
					addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[47]);
					addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[48]);
					addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[49]);
				}
				
			)
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[50]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[51]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[52]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[53]);
			}
			
			(
				(
					(
						a5 = COMMA						
					)
					{
						anonymousTokens.add((org.antlr.runtime3_4_0.CommonToken) a5);
					}
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[54]);
					}
					
					(
						a6 = TEXT						
						{
							if (terminateParsing) {
								throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
							}
							if (element == null) {
								element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
								startIncompleteElement(element);
							}
							if (a6 != null) {
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
								tokenResolver.setOptions(getOptions());
								org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
								tokenResolver.resolve(a6.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES), result);
								Object resolvedObject = result.getResolvedToken();
								if (resolvedObject == null) {
									addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a6).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a6).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a6).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a6).getStopIndex());
								}
								String resolved = (String) resolvedObject;
								org.js.model.rbac.Role proxy = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
								collectHiddenTokens(element);
								registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.Role, org.js.model.rbac.Role>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getRoleParentRolesReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES), resolved, proxy);
								if (proxy != null) {
									Object value = proxy;
									addObjectToList(element, org.js.model.rbac.RbacPackage.ROLE__PARENT_ROLES, value);
									completedElement(value, false);
								}
								collectHiddenTokens(element);
								retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_5_0_0_2_0_0_1, proxy, true);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a6, element);
								copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a6, proxy);
							}
						}
					)
					{
						// expected elements (follow set)
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[55]);
						addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[56]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[57]);
						addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[58]);
					}
					
				)
				
			)*			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[59]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[60]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[61]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[62]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[63]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[64]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[65]);
	}
	
	(
		(
			a7 = '{' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_7_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a7, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[66]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[67]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[68]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[69]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[70]);
			}
			
			(
				(
					a8_0 = parse_org_js_model_rbac_ConfigurationOperation					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
							startIncompleteElement(element);
						}
						if (a8_0 != null) {
							if (a8_0 != null) {
								Object value = a8_0;
								addObjectToList(element, org.js.model.rbac.RbacPackage.ROLE__ALLOWED_CONFIG_OPERATIONS, value);
								completedElement(value, true);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_7_0_0_1, a8_0, true);
							copyLocalizationInfos(a8_0, element);
						}
					}
				)
				
			)*			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[71]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[72]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[73]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[74]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[75]);
			}
			
			(
				(
					a9_0 = parse_org_js_model_rbac_EngineeringOperation					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
							startIncompleteElement(element);
						}
						if (a9_0 != null) {
							if (a9_0 != null) {
								Object value = a9_0;
								addObjectToList(element, org.js.model.rbac.RbacPackage.ROLE__ALLOWED_ENGINEERING_OPERATIONS, value);
								completedElement(value, true);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_7_0_0_2, a9_0, true);
							copyLocalizationInfos(a9_0, element);
						}
					}
				)
				
			)*			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[76]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[77]);
			}
			
			a10 = '}' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_1_0_0_7_0_0_3, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a10, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[78]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[79]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[80]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[81]);
	}
	
;

parse_org_js_model_rbac_CreateFeatureModel returns [org.js.model.rbac.CreateFeatureModel element = null]
@init{
}
:
	a0 = '$createFM' {
		if (element == null) {
			element = org.js.model.rbac.RbacFactory.eINSTANCE.createCreateFeatureModel();
			startIncompleteElement(element);
		}
		collectHiddenTokens(element);
		retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_2_0_0_0, null, true);
		copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a0, element);
	}
	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[82]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[83]);
	}
	
;

parse_org_js_model_rbac_FeatureConfiguration returns [org.js.model.rbac.FeatureConfiguration element = null]
@init{
}
:
	(
		a0 = TEXT		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createFeatureConfiguration();
				startIncompleteElement(element);
			}
			if (a0 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a0.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__FEATURE), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a0).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStopIndex());
				}
				String resolved = (String) resolvedObject;
				org.js.model.feature.Feature proxy = org.js.model.feature.FeatureFactory.eINSTANCE.createFeature();
				collectHiddenTokens(element);
				registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.FeatureReference, org.js.model.feature.Feature>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getFeatureReferenceFeatureReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__FEATURE), resolved, proxy);
				if (proxy != null) {
					Object value = proxy;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__FEATURE), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_3_0_0_1, proxy, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a0, element);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a0, proxy);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[84]);
	}
	
	a1 = ':' {
		if (element == null) {
			element = org.js.model.rbac.RbacFactory.eINSTANCE.createFeatureConfiguration();
			startIncompleteElement(element);
		}
		collectHiddenTokens(element);
		retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_3_0_0_2, null, true);
		copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a1, element);
	}
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[85]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[86]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[87]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[88]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[89]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[90]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[91]);
	}
	
	(
		(
			a2 = S_SELECT			
			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createFeatureConfiguration();
					startIncompleteElement(element);
				}
				if (a2 != null) {
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_SELECT");
					tokenResolver.setOptions(getOptions());
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
					tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__SELECT), result);
					Object resolvedObject = result.getResolvedToken();
					if (resolvedObject == null) {
						addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
					}
					java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
					if (resolved != null) {
						Object value = resolved;
						element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__SELECT), value);
						completedElement(value, false);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_3_0_0_3, resolved, true);
					copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
				}
			}
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[92]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[93]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[94]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[95]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[96]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[97]);
	}
	
	(
		(
			a3 = S_DESELECT			
			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createFeatureConfiguration();
					startIncompleteElement(element);
				}
				if (a3 != null) {
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_DESELECT");
					tokenResolver.setOptions(getOptions());
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
					tokenResolver.resolve(a3.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__DESELECT), result);
					Object resolvedObject = result.getResolvedToken();
					if (resolvedObject == null) {
						addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a3).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a3).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a3).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a3).getStopIndex());
					}
					java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
					if (resolved != null) {
						Object value = resolved;
						element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.FEATURE_CONFIGURATION__DESELECT), value);
						completedElement(value, false);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_3_0_0_4, resolved, true);
					copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a3, element);
				}
			}
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[98]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[99]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[100]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[101]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[102]);
	}
	
;

parse_org_js_model_rbac_AttributeConfiguration returns [org.js.model.rbac.AttributeConfiguration element = null]
@init{
}
:
	(
		a0 = TEXT		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
				startIncompleteElement(element);
			}
			if (a0 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a0.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__FEATURE), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a0).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStopIndex());
				}
				String resolved = (String) resolvedObject;
				org.js.model.feature.Feature proxy = org.js.model.feature.FeatureFactory.eINSTANCE.createFeature();
				collectHiddenTokens(element);
				registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.FeatureReference, org.js.model.feature.Feature>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getFeatureReferenceFeatureReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__FEATURE), resolved, proxy);
				if (proxy != null) {
					Object value = proxy;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__FEATURE), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_1, proxy, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a0, element);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a0, proxy);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[103]);
	}
	
	(
		a1 = DOT		
	)
	{
		anonymousTokens.add((org.antlr.runtime3_4_0.CommonToken) a1);
	}
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[104]);
	}
	
	(
		a2 = TEXT		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
				startIncompleteElement(element);
			}
			if (a2 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__ATTRIBUTE), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
				}
				String resolved = (String) resolvedObject;
				org.js.model.feature.Attribute proxy = org.js.model.feature.FeatureFactory.eINSTANCE.createAttribute();
				collectHiddenTokens(element);
				registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.AttributeConfiguration, org.js.model.feature.Attribute>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getAttributeConfigurationAttributeReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__ATTRIBUTE), resolved, proxy);
				if (proxy != null) {
					Object value = proxy;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__ATTRIBUTE), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_3, proxy, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, proxy);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[105]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[106]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[107]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[108]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[109]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[110]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[111]);
	}
	
	(
		(
			a3 = ':' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_4_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a3, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[112]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[113]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[114]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[115]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[116]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[117]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[118]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[119]);
			}
			
			(
				(
					a4 = S_SELECT					
					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
							startIncompleteElement(element);
						}
						if (a4 != null) {
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_SELECT");
							tokenResolver.setOptions(getOptions());
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
							tokenResolver.resolve(a4.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__SELECT), result);
							Object resolvedObject = result.getResolvedToken();
							if (resolvedObject == null) {
								addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a4).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStopIndex());
							}
							java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
							if (resolved != null) {
								Object value = resolved;
								element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__SELECT), value);
								completedElement(value, false);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_4_0_0_1, resolved, true);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, element);
						}
					}
				)
				
			)?			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[120]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[121]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[122]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[123]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[124]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[125]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[126]);
			}
			
			(
				(
					a5 = S_DESELECT					
					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
							startIncompleteElement(element);
						}
						if (a5 != null) {
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_DESELECT");
							tokenResolver.setOptions(getOptions());
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
							tokenResolver.resolve(a5.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__DESELECT), result);
							Object resolvedObject = result.getResolvedToken();
							if (resolvedObject == null) {
								addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a5).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a5).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a5).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a5).getStopIndex());
							}
							java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
							if (resolved != null) {
								Object value = resolved;
								element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__DESELECT), value);
								completedElement(value, false);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_4_0_0_2, resolved, true);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a5, element);
						}
					}
				)
				
			)?			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[127]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[128]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[129]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[130]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[131]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[132]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[133]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[134]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[135]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[136]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[137]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[138]);
	}
	
	(
		(
			a6 = '(' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_5_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a6, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAttributeConfiguration(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[139]);
			}
			
			(
				(
					a7_0 = parse_org_js_model_rbac_DomainValueConfiguration					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
							startIncompleteElement(element);
						}
						if (a7_0 != null) {
							if (a7_0 != null) {
								Object value = a7_0;
								addObjectToList(element, org.js.model.rbac.RbacPackage.ATTRIBUTE_CONFIGURATION__VALUE_CONFIGURATIONS, value);
								completedElement(value, true);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_5_0_0_1, a7_0, true);
							copyLocalizationInfos(a7_0, element);
						}
					}
				)
				
			)+			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAttributeConfiguration(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[140]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[141]);
			}
			
			a8 = ')' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createAttributeConfiguration();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_4_0_0_5_0_0_2, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a8, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[142]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[143]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[144]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[145]);
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[146]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[147]);
			}
			
		)
		
	)*	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[148]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[149]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[150]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[151]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[152]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[153]);
	}
	
;

parse_org_js_model_rbac_DomainValueConfiguration returns [org.js.model.rbac.DomainValueConfiguration element = null]
@init{
}
:
	(
		(
			a0 = QUOTED_34_34			
			{
				if (terminateParsing) {
					throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
				}
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createDomainValueConfiguration();
					startIncompleteElement(element);
				}
				if (a0 != null) {
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_34_34");
					tokenResolver.setOptions(getOptions());
					org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
					tokenResolver.resolve(a0.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__VALUE), result);
					Object resolvedObject = result.getResolvedToken();
					if (resolvedObject == null) {
						addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a0).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a0).getStopIndex());
					}
					java.lang.String resolved = (java.lang.String) resolvedObject;
					if (resolved != null) {
						Object value = resolved;
						element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__VALUE), value);
						completedElement(value, false);
					}
					collectHiddenTokens(element);
					retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_5_0_0_0_0_0_0, resolved, true);
					copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a0, element);
				}
			}
		)
		{
			// expected elements (follow set)
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[154]);
		}
		
		a1 = ':' {
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createDomainValueConfiguration();
				startIncompleteElement(element);
			}
			collectHiddenTokens(element);
			retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_5_0_0_0_0_0_1, null, true);
			copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a1, element);
		}
		{
			// expected elements (follow set)
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[155]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[156]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[157]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[158]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[159]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[160]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[161]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[162]);
		}
		
		(
			(
				a2 = S_SELECT				
				{
					if (terminateParsing) {
						throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
					}
					if (element == null) {
						element = org.js.model.rbac.RbacFactory.eINSTANCE.createDomainValueConfiguration();
						startIncompleteElement(element);
					}
					if (a2 != null) {
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_SELECT");
						tokenResolver.setOptions(getOptions());
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
						tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__SELECT), result);
						Object resolvedObject = result.getResolvedToken();
						if (resolvedObject == null) {
							addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
						}
						java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
						if (resolved != null) {
							Object value = resolved;
							element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__SELECT), value);
							completedElement(value, false);
						}
						collectHiddenTokens(element);
						retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_5_0_0_0_0_0_2, resolved, true);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
					}
				}
			)
			
		)?		{
			// expected elements (follow set)
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[163]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[164]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[165]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[166]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[167]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[168]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[169]);
		}
		
		(
			(
				a3 = S_DESELECT				
				{
					if (terminateParsing) {
						throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
					}
					if (element == null) {
						element = org.js.model.rbac.RbacFactory.eINSTANCE.createDomainValueConfiguration();
						startIncompleteElement(element);
					}
					if (a3 != null) {
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("S_DESELECT");
						tokenResolver.setOptions(getOptions());
						org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
						tokenResolver.resolve(a3.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__DESELECT), result);
						Object resolvedObject = result.getResolvedToken();
						if (resolvedObject == null) {
							addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a3).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a3).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a3).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a3).getStopIndex());
						}
						java.lang.Boolean resolved = (java.lang.Boolean) resolvedObject;
						if (resolved != null) {
							Object value = resolved;
							element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.DOMAIN_VALUE_CONFIGURATION__DESELECT), value);
							completedElement(value, false);
						}
						collectHiddenTokens(element);
						retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_5_0_0_0_0_0_3, resolved, true);
						copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a3, element);
					}
				}
			)
			
		)?		{
			// expected elements (follow set)
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[170]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[171]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[172]);
			addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[173]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[174]);
			addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[175]);
		}
		
	)
	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[176]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[177]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[178]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getRole(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[179]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[180]);
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[181]);
	}
	
;

parse_org_js_model_rbac_Subject returns [org.js.model.rbac.Subject element = null]
@init{
}
:
	a0 = 'subject' {
		if (element == null) {
			element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
			startIncompleteElement(element);
		}
		collectHiddenTokens(element);
		retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_0, null, true);
		copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a0, element);
	}
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[182]);
	}
	
	(
		a1 = QUOTED_34_34		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
				startIncompleteElement(element);
			}
			if (a1 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_34_34");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a1.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__NAME), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a1).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a1).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a1).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a1).getStopIndex());
				}
				java.lang.String resolved = (java.lang.String) resolvedObject;
				if (resolved != null) {
					Object value = resolved;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__NAME), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_2, resolved, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a1, element);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[183]);
	}
	
	(
		a2 = QUOTED_60_62		
		{
			if (terminateParsing) {
				throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
			}
			if (element == null) {
				element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
				startIncompleteElement(element);
			}
			if (a2 != null) {
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("QUOTED_60_62");
				tokenResolver.setOptions(getOptions());
				org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
				tokenResolver.resolve(a2.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__ID), result);
				Object resolvedObject = result.getResolvedToken();
				if (resolvedObject == null) {
					addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a2).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a2).getStopIndex());
				}
				java.lang.String resolved = (java.lang.String) resolvedObject;
				if (resolved != null) {
					Object value = resolved;
					element.eSet(element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__ID), value);
					completedElement(value, false);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_4, resolved, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a2, element);
			}
		}
	)
	{
		// expected elements (follow set)
		addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[184]);
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[185]);
	}
	
	(
		(
			a3 = '{' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_6_0_0_0, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a3, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[186]);
			}
			
			(
				(
					a4 = TEXT					
					{
						if (terminateParsing) {
							throw new org.js.model.rbac.resource.rbactext.mopp.RbactextTerminateParsingException();
						}
						if (element == null) {
							element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
							startIncompleteElement(element);
						}
						if (a4 != null) {
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolver tokenResolver = tokenResolverFactory.createTokenResolver("TEXT");
							tokenResolver.setOptions(getOptions());
							org.js.model.rbac.resource.rbactext.IRbactextTokenResolveResult result = getFreshTokenResolveResult();
							tokenResolver.resolve(a4.getText(), element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__ROLES), result);
							Object resolvedObject = result.getResolvedToken();
							if (resolvedObject == null) {
								addErrorToResource(result.getErrorMessage(), ((org.antlr.runtime3_4_0.CommonToken) a4).getLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getCharPositionInLine(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStartIndex(), ((org.antlr.runtime3_4_0.CommonToken) a4).getStopIndex());
							}
							String resolved = (String) resolvedObject;
							org.js.model.rbac.Role proxy = org.js.model.rbac.RbacFactory.eINSTANCE.createRole();
							collectHiddenTokens(element);
							registerContextDependentProxy(new org.js.model.rbac.resource.rbactext.mopp.RbactextContextDependentURIFragmentFactory<org.js.model.rbac.Subject, org.js.model.rbac.Role>(getReferenceResolverSwitch() == null ? null : getReferenceResolverSwitch().getSubjectRolesReferenceResolver()), element, (org.eclipse.emf.ecore.EReference) element.eClass().getEStructuralFeature(org.js.model.rbac.RbacPackage.SUBJECT__ROLES), resolved, proxy);
							if (proxy != null) {
								Object value = proxy;
								addObjectToList(element, org.js.model.rbac.RbacPackage.SUBJECT__ROLES, value);
								completedElement(value, false);
							}
							collectHiddenTokens(element);
							retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_6_0_0_1, proxy, true);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, element);
							copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken) a4, proxy);
						}
					}
				)
				
			)+			{
				// expected elements (follow set)
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[187]);
				addExpectedElement(null, org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[188]);
			}
			
			a5 = '}' {
				if (element == null) {
					element = org.js.model.rbac.RbacFactory.eINSTANCE.createSubject();
					startIncompleteElement(element);
				}
				collectHiddenTokens(element);
				retrieveLayoutInformation(element, org.js.model.rbac.resource.rbactext.grammar.RbactextGrammarInformationProvider.RBACTEXT_6_0_0_6_0_0_2, null, true);
				copyLocalizationInfos((org.antlr.runtime3_4_0.CommonToken)a5, element);
			}
			{
				// expected elements (follow set)
				addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[189]);
			}
			
		)
		
	)?	{
		// expected elements (follow set)
		addExpectedElement(org.js.model.rbac.RbacPackage.eINSTANCE.getAccessControlModel(), org.js.model.rbac.resource.rbactext.mopp.RbactextExpectationConstants.EXPECTATIONS[190]);
	}
	
;

parse_org_js_model_rbac_ConfigurationOperation returns [org.js.model.rbac.ConfigurationOperation element = null]
:
	c0 = parse_org_js_model_rbac_FeatureConfiguration{ element = c0; /* this is a subclass or primitive expression choice */ }
	|	c1 = parse_org_js_model_rbac_AttributeConfiguration{ element = c1; /* this is a subclass or primitive expression choice */ }
	|	c2 = parse_org_js_model_rbac_DomainValueConfiguration{ element = c2; /* this is a subclass or primitive expression choice */ }
	
;

parse_org_js_model_rbac_EngineeringOperation returns [org.js.model.rbac.EngineeringOperation element = null]
:
	c0 = parse_org_js_model_rbac_CreateFeatureModel{ element = c0; /* this is a subclass or primitive expression choice */ }
	
;

S_DESELECT:
	('deselect')
;
S_SELECT:
	('select')
;
COMMA:
	((','|';'))
;
DOT:
	(('.'))
;
COMMENT:
	('//'(~('\n'|'\r'|'\uffff'))* )
	{ _channel = 99; }
;
TEXT:
	(('A'..'Z' | 'a'..'z' | '0'..'9' | '_' | '-' )+)
;
WHITESPACE:
	((' ' | '\t' | '\f'))
	{ _channel = 99; }
;
LINEBREAK:
	(('\r\n' | '\r' | '\n'))
	{ _channel = 99; }
;
QUOTED_60_62:
	(('<')(~('>'))*('>'))
;
QUOTED_34_34:
	(('"')(~('"'))*('"'))
;

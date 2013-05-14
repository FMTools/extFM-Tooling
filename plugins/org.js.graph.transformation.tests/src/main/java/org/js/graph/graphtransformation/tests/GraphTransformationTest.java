/**
 */
package org.js.graph.graphtransformation.tests;

import junit.framework.TestCase;

import junit.textui.TestRunner;

import org.js.graph.graphtransformation.GraphTransformation;
import org.js.graph.graphtransformation.GraphtransformationFactory;

/**
 * <!-- begin-user-doc -->
 * A test case for the model object '<em><b>Graph Transformation</b></em>'.
 * <!-- end-user-doc -->
 * @generated
 */
public class GraphTransformationTest extends TestCase {

	/**
	 * The fixture for this Graph Transformation test case.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected GraphTransformation fixture = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public static void main(String[] args) {
		TestRunner.run(GraphTransformationTest.class);
	}

	/**
	 * Constructs a new Graph Transformation test case with the given name.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public GraphTransformationTest(String name) {
		super(name);
	}

	/**
	 * Sets the fixture for this Graph Transformation test case.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected void setFixture(GraphTransformation fixture) {
		this.fixture = fixture;
	}

	/**
	 * Returns the fixture for this Graph Transformation test case.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected GraphTransformation getFixture() {
		return fixture;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see junit.framework.TestCase#setUp()
	 * @generated
	 */
	@Override
	protected void setUp() throws Exception {
		setFixture(GraphtransformationFactory.eINSTANCE.createGraphTransformation());
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see junit.framework.TestCase#tearDown()
	 * @generated
	 */
	@Override
	protected void tearDown() throws Exception {
		setFixture(null);
	}

} //GraphTransformationTest
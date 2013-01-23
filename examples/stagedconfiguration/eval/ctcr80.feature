<?xml version="1.0" encoding="UTF-8"?>
<feature:FeatureModel xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:feature="http://www.tudresden.de/extfeature" name="ctcr80">
  <root id="root" name="root" selected="unbound">
    <groups id="man" minCardinality="1" maxCardinality="1">
      <childFeatures id="f1" name="f1" selected="unbound">
        <groups id="of1" maxCardinality="2">
          <childFeatures id="f2" name="f2" selected="unbound"/>
          <childFeatures id="f3" name="f3" selected="unbound">
            <groups id="of3" maxCardinality="2">
              <childFeatures id="f5" name="f5" selected="unbound"/>
              <childFeatures id="f7" name="f7" selected="unbound"/>
            </groups>
            <groups id="mf3" minCardinality="1" maxCardinality="1">
              <childFeatures id="f6" name="f6" selected="unbound"/>
            </groups>
            <groups id="altf3" minCardinality="1" maxCardinality="1">
              <childFeatures id="f8" name="f8" selected="unbound">
                <groups id="of8" maxCardinality="1">
                  <childFeatures id="f11" name="f11" selected="unbound"/>
                </groups>
                <groups id="mf8" minCardinality="4" maxCardinality="4">
                  <childFeatures id="f10" name="f10" selected="unbound">
                    <groups id="mf10" minCardinality="2" maxCardinality="2">
                      <childFeatures id="f18" name="f18" selected="unbound"/>
                      <childFeatures id="f19" name="f19" selected="unbound"/>
                    </groups>
                    <groups id="orf10" minCardinality="1" maxCardinality="2">
                      <childFeatures id="f20" name="f20" selected="unbound"/>
                      <childFeatures id="f21" name="f21" selected="unbound"/>
                    </groups>
                  </childFeatures>
                  <childFeatures id="f12" name="f12" selected="unbound"/>
                  <childFeatures id="f13" name="f13" selected="unbound"/>
                  <childFeatures id="f14" name="f14" selected="unbound"/>
                </groups>
                <groups id="altf8" minCardinality="1" maxCardinality="1">
                  <childFeatures id="f15" name="f15" selected="unbound"/>
                  <childFeatures id="f16" name="f16" selected="unbound"/>
                  <childFeatures id="f17" name="f17" selected="unbound">
                    <groups id="f17" minCardinality="1" maxCardinality="1">
                      <childFeatures id="f22" name="f22" selected="unbound"/>
                    </groups>
                  </childFeatures>
                </groups>
              </childFeatures>
              <childFeatures id="f9" name="f9" selected="unbound"/>
            </groups>
          </childFeatures>
        </groups>
        <groups id="mf1" minCardinality="1" maxCardinality="1">
          <childFeatures id="f4" name="f4" selected="unbound"/>
        </groups>
      </childFeatures>
    </groups>
  </root>
  <constraints id="c1">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f10"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f5"/>
    </expression>
  </constraints>
  <constraints id="c2">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f19"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f16"/>
    </expression>
  </constraints>
  <constraints id="c3">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f9"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f10"/>
    </expression>
  </constraints>
  <constraints id="c4">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f12"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f9"/>
    </expression>
  </constraints>
  <constraints id="c5">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f12"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f4"/>
    </expression>
  </constraints>
  <constraints id="c6">
    <expression xsi:type="feature:ExcludesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f6"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f7"/>
    </expression>
  </constraints>
  <constraints id="c7">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f2"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f17"/>
    </expression>
  </constraints>
  <constraints id="c8">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f10"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f14"/>
    </expression>
  </constraints>
  <constraints id="c9">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f12"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f6"/>
    </expression>
  </constraints>
  <constraints id="c10">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f21"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f13"/>
    </expression>
  </constraints>
  <constraints id="c11">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f14"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f17"/>
    </expression>
  </constraints>
  <constraints id="c12">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f7"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f13"/>
    </expression>
  </constraints>
  <constraints id="c13">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f11"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f21"/>
    </expression>
  </constraints>
  <constraints id="c14">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f19"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f15"/>
    </expression>
  </constraints>
  <constraints id="c15">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f21"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f2"/>
    </expression>
  </constraints>
  <constraints id="c16">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f16"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f15"/>
    </expression>
  </constraints>
  <constraints id="c17">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f20"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f4"/>
    </expression>
  </constraints>
  <constraints id="c18">
    <expression xsi:type="feature:ImpliesExpression">
      <operand1 xsi:type="feature:FeatureReference" feature="f2"/>
      <operand2 xsi:type="feature:FeatureReference" feature="f9"/>
    </expression>
  </constraints>
</feature:FeatureModel>

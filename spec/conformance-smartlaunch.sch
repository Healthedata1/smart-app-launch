<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile Conformance
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>Conformance</sch:title>
    <sch:rule context="f:Conformance">
      <sch:assert test="not(exists(f:software) or exists(f:implementation)) or (f:kind/@value != 'requirements')">Conformance statements of kind 'requirements' do not have software or implementation elements (inherited)</sch:assert>
      <sch:assert test="exists(f:rest) or exists(f:messaging) or exists(f:document)">A Conformance statement SHALL have at least one of REST, messaging or document (inherited)</sch:assert>
      <sch:assert test="not(exists(f:implementation)) or (f:kind/@value != 'capability')">Conformance statements of kind 'software' do not have implementation elements (inherited)</sch:assert>
      <sch:assert test="count(f:software | f:implementation | f:description) &gt; 0">A Conformance statement SHALL have at least one of description, software, or implementation (inherited)</sch:assert>
      <sch:assert test="not(exists(f:messaging/f:endpoint)) or f:kind/@value = 'instance'">Messaging end-point is required (and is only permitted) when statement is for an implementation (inherited)</sch:assert>
      <sch:assert test="count(f:document[f:mode/@value='producer'])=count(distinct-values(f:document[f:mode/@value='producer']/f:profile/f:reference/@value)) and count(f:document[f:mode/@value='consumer'])=count(distinct-values(f:document[f:mode/@value='consumer']/f:profile/f:reference/@value))">The set of documents must be unique by the combination of profile &amp; mode (inherited)</sch:assert>
      <sch:assert test="count(f:rest)=count(distinct-values(f:rest/f:mode/@value))">There can only be one REST declaration per mode (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Conformance.rest</sch:title>
    <sch:rule context="f:Conformance/f:rest">
      <sch:assert test="count(f:resource)=count(distinct-values(f:resource/f:type/@value))">A given resource can only be described once per RESTful mode (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:Conformance/f:rest/f:security</sch:title>
    <sch:rule context="f:Conformance/f:rest/f:security">
      <sch:assert test="count(f:extension[@url = 'http://hl7.org/fhir/DSTU2/smart-app-launch/StructureDefinition/extension-dstu2-oauth-uris']) &gt;= 1">extension with URL = 'http://hl7.org/fhir/DSTU2/smart-app-launch/StructureDefinition/extension-dstu2-oauth-uris': minimum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'http://hl7.org/fhir/DSTU2/smart-app-launch/StructureDefinition/extension-dstu2-oauth-uris']) &lt;= 1">extension with URL = 'http://hl7.org/fhir/DSTU2/smart-app-launch/StructureDefinition/extension-dstu2-oauth-uris': maximum cardinality of 'extension' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Conformance.rest.resource</sch:title>
    <sch:rule context="f:Conformance/f:rest/f:resource">
      <sch:assert test="count(f:searchParam)=count(distinct-values(f:searchParam/f:name/@value))">Search parameter names must be unique in the context of a resource (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>Conformance.rest.resource.searchParam</sch:title>
    <sch:rule context="f:Conformance/f:rest/f:resource/f:searchParam">
      <sch:assert test="not(exists(f:chain)) or (f:type/@value = 'reference')">Search parameters can only have chain names when the search parameter type is 'reference' (inherited)</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>

DECLARE
  l_relations relation_table := relation_table('student', 'department', 'course');
  l_predicates SYS_REFCURSOR;
  l_fragments VARCHAR2(1000);
BEGIN
  OPEN l_predicates FOR SELECT subject, predicate_name, object FROM predicates;

  horizontal_miniterm_fragment_generator.generate_fragments(l_relations, l_predicates, l_fragments);

  DBMS_OUTPUT.PUT_LINE(l_fragments);
END;


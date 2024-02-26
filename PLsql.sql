CREATE OR REPLACE PACKAGE horizontal_miniterm_fragment_generator AS
  TYPE relation_table IS TABLE OF VARCHAR2(100);

  PROCEDURE generate_fragments(
    relations IN relation_table,
    predicates IN OUT SYS_REFCURSOR,
    fragments OUT VARCHAR2(1000)
  );
END;
/

CREATE OR REPLACE PACKAGE BODY horizontal_miniterm_fragment_generator AS
  PROCEDURE generate_fragments(
    relations IN relation_table,
    predicates IN OUT SYS_REFCURSOR,
    fragments OUT VARCHAR2(1000)
  ) IS
    l_predicate record (
      subject VARCHAR2(100),
      predicate_name VARCHAR2(100),
      object VARCHAR2(100)
    );
  BEGIN
    OPEN predicates;
    LOOP
      FETCH predicates INTO l_predicate;
      EXIT WHEN predicates%NOTFOUND;

      fragments := fragments || l_predicate.subject || '.' || l_predicate.predicate_name || ' = ';
      IF INSTR(relations, l_predicate.object) > 0 THEN
        fragments := fragments || l_predicate.object;
      ELSE
        fragments := fragments || '?'; -- Use placeholder for variables
      END IF;
      fragments := fragments || CHR(10); -- Add newline for each fragment
    END LOOP;
    CLOSE predicates;
  END;
/


-- Example usage
DECLARE
  l_relations relation_table := relation_table('customer', 'order', 'product');
  l_predicates SYS_REFCURSOR;
  l_fragments VARCHAR2(1000);
BEGIN
  OPEN l_predicates FOR SELECT subject, predicate_name, object FROM predicates; -- Replace with your actual SELECT statement

  horizontal_miniterm_fragment_generator.generate_fragments(l_relations, l_predicates, l_fragments);

  DBMS_OUTPUT.PUT_LINE(l_fragments);
END;
/




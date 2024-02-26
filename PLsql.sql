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
        fragments := fragments || '?'; 
      END IF;
      fragments := fragments || CHR(10); 
    END LOOP;
    CLOSE predicates;
  END;
/





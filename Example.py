from hor_fragment import * 

predicates = [("student", "entered_department", "department"), ("department", "includes", "course")]
relations = ["student", "department", "course"]

print("work hear")
generator = GeneratorHorizontalMinitermFragment(relations)
print("hear too")
fragments = generator.gen_fragments(predicates)
print(fragments)

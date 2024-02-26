from hor_fragment import * 

relations = ["customer", "order", "product"]
predicates = [("customer", "placed_order", "order"), ("order", "includes", "product")]
print("work hear")
generator = HorizontalMinitermFragmentGenerator(relations)
print("hear too")
fragments = generator.generate_fragments(predicates)
print(fragments)

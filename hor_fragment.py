class HorizontalMinitermFragmentGenerator:
    def __init__(self, relations):
        self.relations = relations

    def generate_fragments(self, predicates):
        fragments = []
        for predicate in predicates:
            subject, predicate_name, object_ = predicate  # Unpack predicate elements

            fragment = subject + "." + predicate_name + " = "
            if object_ in self.relations:
                fragment += object_  # Directly append relation name if it's a relation
            else:
                fragment += "?"  # Use placeholder for variables
            fragments.append(fragment)
        return fragments





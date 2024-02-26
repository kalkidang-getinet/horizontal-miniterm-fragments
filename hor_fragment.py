class GeneratorHorizontalMinitermFragment:
    def __init__(self, relations):
        self.relations = relations

    def gen_fragments(self, predicates):
        fragments = []
        for predicate in predicates:
            subject, predicate_name, object_ = predicate 

            fragment = subject + "." + predicate_name + " = "
            if object_ in self.relations:
                fragment += object_ 
            else:
                fragment += "?"  
            fragments.append(fragment)
        return fragments





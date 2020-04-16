
from __future__ import print_function
import random

buzz = ('prueba1', 'prueba2',
    'prueba3')
adjectives = ('Alberto', 'Luis', 'Jose', 'Manuel')
adverbs = ('es', 'no es')
verbs = ('guapo', 'feo', 'tonto', 'listo')

def sample(l, n = 1):
    result = random.sample(l, n)
    if n == 1:
        return result[0]
    return result

def generate_buzz():
    buzz_terms = sample(buzz, 2)
    phrase = ' '.join([sample(adjectives), sample(adverbs), sample(verbs)])
    return phrase.title()

if __name__ == "__main__":
    print(generate_buzz())
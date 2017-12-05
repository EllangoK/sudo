import json, random
import matplotlib.pyplot as plt 

from pprint import pprint 
db = json.load(open('./db.json','rb'))

entry = random.choice(db.values())
pprint(entry)
import csv

def parse_pokemon_info(line):
	poke_id = int(line.split('data-sort-value="')[1].split('"')[0])
	pokemon_entry = {}
	pokemon_entry['name'] = line.split('href="/pokedex/')[1].split('"')[0]
	pokemon_entry['type1'] = line.split('href="/type/')[1].split('"')[0]
	if (len(line.split('href="/type/')) > 2):
		pokemon_entry['type2'] = line.split('href="/type/')[2].split('"')[0]
	else:
		pokemon_entry['type2'] = 'none'

	if (poke_id >= 1 and poke_id <= 151):
		pokemon_entry['region'] = 'Kanto'
	elif (poke_id >= 152 and poke_id <= 251):
		pokemon_entry['region'] = 'Johto'
	elif (poke_id >= 252 and poke_id <= 386):
		pokemon_entry['region'] = 'Hoenn'
	elif (poke_id >= 387 and poke_id <= 494):
		pokemon_entry['region'] = 'Sinnoh'
	elif (poke_id >= 495 and poke_id <= 649):
		pokemon_entry['region'] = 'Unova'
	elif (poke_id >= 650 and poke_id <= 722):
		pokemon_entry['region'] = 'Kalos'
	else:
		pokemon_entry['region'] = 'Alola'

	return pokemon_entry


def create_pokemon_data():
	file = open('pokemon-data.txt', 'r')
	lines = file.readlines()

	pokemon_data = []
	for line in lines:
		if (line.startswith('<td class="num cell-icon-string" data-sort-value="')):
			pokemon_data.append(parse_pokemon_info(line))
		elif (line.startswith('<td class="num">')):
			pass # stats; ignore for now
		else:
			pass # do nothing

	file.close()

	return pokemon_data

def write_csv(pokemon_data):
	file = open('pokemon-data.csv', 'w')
	writer = csv.DictWriter(file, fieldnames=['name', 'type1', 'type2', 'region'])
	writer.writeheader()
	for pokemon_row in pokemon_data:
		writer.writerow(pokemon_row)
	file.close()
	print 'Done writing to csv!'

def main():
	pokemon_data = create_pokemon_data()
	write_csv(pokemon_data)
	

if __name__ == "__main__":
	main()
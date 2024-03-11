# Définition des cibles (targets)

.PHONY: lint test doc coverage

# Analyse statique du code avec Pylint ou Flake8
#	-docker-compose exec biblio_app flake8 /app
lint:
	-docker-compose exec biblio_app pylint app.py models.py importer.py
#	-docker-compose exec biblio_app flake8 .

# Exécution des tests unitaires avec pytest
test:
	-docker-compose exec biblio_app pytest

# Génération de la documentation avec pdoc
doc:
	-docker-compose exec biblio_app pdoc --html .

# Vérification de la couverture du code avec coverage
coverage:
	-docker-compose exec biblio_app coverage run -m pytest
	-docker-compose exec biblio_app coverage report -m

# Exécution de toutes les tâches
all: lint test doc coverage
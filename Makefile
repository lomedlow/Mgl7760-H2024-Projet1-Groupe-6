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
	-docker-compose exec biblio_app pytest --junitxml=reports/test-results.xml


# Génération de la documentation avec pdoc
doc:
	docker-compose exec biblio_app pdoc --force --html .
	docker cp biblio:/app/html/app.html ./documentation_pdoc/app_pdoc.html

# Vérification de la couverture du code avec coverage
coverage:
	-docker-compose exec biblio_app coverage run -m pytest
	-docker-compose exec biblio_app coverage report -m
	-docker-compose exec biblio_app coverage xml -o reports/coverage.xml


#Copie des rapports
copy-reports:
	docker cp biblio:/app/reports/test-results.xml ./reports/test-results.xml
	docker cp biblio:/app/reports/coverage.xml ./reports/coverage.xml


# Exécution de toutes les tâches
all: lint test doc coverage copy-reports
# Définition des cibles (targets)

.PHONY: lint test doc coverage

# Analyse statique du code avec Pylint ou Flake8
#	-docker-compose exec biblio_app flake8 /app
lint:
	-docker-compose exec biblio_app1 flake8 app.py models.py importer.py
#	-docker-compose exec biblio_app flake8 .

# Exécution des tests unitaires avec pytest
test:
#	 -docker-compose exec biblio_app1 pytest
	-sh 'docker-compose exec biblio_app1 pytest'
	-docker-compose exec biblio_app1 pytest --junitxml=reports/test-results.xml

# Génération de la documentation avec pdoc
doc:
	-docker-compose exec biblio_app1 pdoc --force --html .
	-docker cp biblio1:/app/html/app.html ./documentation_pdoc/app_pdoc.html

# Vérification de la couverture du code avec coverage
coverage:
	-docker-compose exec biblio_app1 coverage run -m pytest
	-docker-compose exec biblio_app1 coverage report -m
	-docker-compose exec biblio_app1 coverage xml -o reports/coverage.xml


#Copie des rapports
copy-reports:
	docker cp biblio1:/app/reports/test-results.xml ./test-results.xml
	docker cp biblio1:/app/reports/coverage.xml ./coverage.xml


# Exécution de toutes les tâches
all: lint test doc coverage copy-reports
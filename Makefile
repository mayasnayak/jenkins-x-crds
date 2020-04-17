CHART_REPO := gs://jenkinsxio-labs-private/charts
NAME := jenkins-x-crds

build: clean
	helm lint

clean:
	rm -rf charts
	rm -rf ${NAME}*.tgz

release: clean
	sed -i -e "s/version:.*/version: $(VERSION)/" Chart.yaml
	helm lint
	helm package .
	helm repo add jx-labs $(CHART_REPO)
	# helm gcs push ${NAME}*.tgz jx-labs --public
	helm gcs push ${NAME}*.tgz jx-labs
	rm -rf ${NAME}*.tgz%
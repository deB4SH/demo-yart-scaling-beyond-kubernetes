Demo for Blog Post Scaling Beyond Kubernetes
====

Link to blog: TODO - will be released soon

----

This repository shows two use cases of templating the infrastructure behind kubernetes clusters and correlating manifests. Not everything scale with a simple change of a horizontal pod autoscaler. The first case demonstrates a simple case of a single cluster that gets templated. The schema describes all required variables within the config.yaml. Some variables are not required by schema or do receive a default value which is not required to be configured. Everything is run within a docker based on the version 1.0.3 of yart available here: https://github.com/deB4SH/YART

The second usecase describe an extension of the first. The schema definition is completly similar and just extends the idea with a multi cluster setup to render the manifests for multiple clusters at once. 

Within both folders exist a `build.sh` and `test.sh` that should help getting things going. The script checks if there is git available and tries to use docker or podman. 

Everything is currently tested with podman.
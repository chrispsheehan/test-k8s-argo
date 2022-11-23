local Deployment = import "./base/deployment.libsonnet";
local Replica = import "./base/replicaset.libsonnet";
local Pod = import "./base/pod.libsonnet";
local Base = import "./base/metadata.libsonnet";
local Config = import "config.libsonnet";

Deployment.Spec(Config.App.Name) {
    spec: Replica.Spec(Config.App.Name, Config.App.Replicas) {
        template: Base.Metadata(Config.App.Name, Config.App.Name) {
            spec: Pod.Template(Config.App.Name) {
                containers: [
                    {
                        name: Config.App.Name,
                        image: Config.App.Image,
                        ports: [
                            {
                                containerPort: Config.App.Port,
                            },
                        ],
                    },
                ],
            },
        },
    },
}
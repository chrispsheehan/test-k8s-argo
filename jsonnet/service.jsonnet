local Config = import "config.libsonnet";
local Service = import "./base/service.libsonnet";

Service.Spec(Config.App.Service) {
    spec: {
        selector: {
            id: Config.App.Name,
        },
        ports: [
            {
                name: 'http',
                protocol: 'TCP',
                port: 80,
                targetPort: Config.App.Port,
            },
        ],
    },
}
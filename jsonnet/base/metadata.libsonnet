local Config = import "../config.libsonnet";

{
    Metadata(name, id): {
        metadata: {
            name: name,
            labels: {
                id: id,
            },
            namespace: Config.Namespace,
        },
    },
}
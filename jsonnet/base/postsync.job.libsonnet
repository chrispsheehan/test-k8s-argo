local Config = import "../config.libsonnet";

{
    Spec(name): {
        apiVersion: 'batch/v1',
        kind: 'Job',
        metadata: {
            annotations: {
                'argocd.argoproj.io/hook': 'PostSync',
            },
            name: name,
            namespace: Config.Namespace,
        }
    },
}
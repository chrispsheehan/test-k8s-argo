local Config = import "../config.libsonnet";

{
    Spec(name, wave): {
        apiVersion: 'batch/v1',
        kind: 'Job',
        metadata: {
            annotations: {
                'argocd.argoproj.io/hook': 'PostSync',
                'argocd.argoproj.io/sync-wave': wave,
            },
            name: (name + "-wave" + wave),
            namespace: Config.Namespace,
        }
    },
}
local Config = import "base/config.libsonnet";

[
  {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: {
      name: Config.Namespace,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'nginx-deployment',
      namespace: Config.Namespace,
      labels: {
        app: 'nginx',
      },
    },
    spec: {
      replicas: 3,
      selector: {
        matchLabels: {
          app: 'nginx',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'nginx',
          },
        },
        spec: {
          containers: [
            {
              name: 'nginx',
              image: 'nginx:1.14.2',
              ports: [
                {
                  containerPort: 80,
                },
              ],
            },
          ],
        },
      },
    },
  },
  {
    apiVersion: 'batch/v1',
    kind: 'Job',
    metadata: {
      annotations: {
        'argocd.argoproj.io/hook': 'PostSync',
      },
      name: 'testbox',
      namespace: Config.Namespace,
    },
    spec: {
      template: {
        spec: {
          containers: [
            {
              command: [
                'sh',
                '-c',
                'sleep 2 && echo hi QA team jsonnet too',
              ],
              image: 'busybox',
              name: 'test-thing',
            },
          ],
          restartPolicy: 'Never',
        },
      },
      backoffLimit: 4,
    },
  },
]
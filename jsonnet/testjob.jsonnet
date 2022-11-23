local PostSyncJob = import "./base/postsync.job.libsonnet";
local Config = import "config.libsonnet";


PostSyncJob.Spec(Config.Test.Name) {
    spec: {
        template: {
            spec: {
                containers: [
                    {
                        command: [
                            'sh',
                            '-c',
                            'sleep 2 && echo hi QA team jsonnet too blah',
                        ],
                        image: Config.Test.Image,
                        name: Config.Test.Name,
                    },
                ],
                restartPolicy: 'Never',
            },
        },
        backoffLimit: Config.Test.BackoffLimit,
    },
}
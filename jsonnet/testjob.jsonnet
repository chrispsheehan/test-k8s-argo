local PostSyncJob = import "./base/postsync.job.libsonnet";
local Config = import "config.libsonnet";
local TargetAppUrl = 'http://' + Config.App.Service + '.' + Config.Namespace + '.svc.cluster.local';


PostSyncJob.Spec(Config.Test.Name, 1) {
    spec: {
        template: {
            spec: {
                containers: [
                    {
                        // this could execute some tests :)
                        // a SyncFail could report any issues
                        command: [
                            "/usr/bin/curl"
                        ],
                        args: [
                            TargetAppUrl
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
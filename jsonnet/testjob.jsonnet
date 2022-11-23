local PostSyncJob = import "./base/postsync.job.libsonnet";
local Config = import "config.libsonnet";
local TargetAppUrl = 'http://' + Config.App.Service + '.' + Config.Namespace + '.svc.cluster.local';


PostSyncJob.Spec(Config.Test.Name) {
    spec: {
        template: {
            spec: {
                containers: [
                    {
                        command: [
                            "nginx", 
                            "-g", 
                            "daemon off;",
                            'curl ' + TargetAppUrl
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
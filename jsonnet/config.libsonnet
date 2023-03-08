{
    Namespace:: 'project-app-x',

    App:: {
        Image: 'nginx',
        Name: 'nginx',
        Replicas: 2,
        Port: 80,
        Service: 'app-service'
    },

    Test:: {
        Image: 'nginx:alpine',
        Name: 'test-boxss',
        BackoffLimit: 1
    }
}
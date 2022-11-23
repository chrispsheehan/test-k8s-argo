{
    Namespace:: 'project-x',

    App:: {
        Image: 'nginx',
        Name: 'nginx',
        Replicas: 2,
        Port: 80,
        Service: 'app-service'
    },

    Test:: {
        Image: 'nginx:alpine',
        Name: 'test-box',
        BackoffLimit: 1
    }
}
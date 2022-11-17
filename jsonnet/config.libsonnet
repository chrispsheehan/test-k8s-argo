{
    Namespace:: 'project-x',

    App:: {
        Image: 'nginx:1.14.2',
        Name: 'nginx',
        Replicas: 2,
        Port: 80
    },

    Test:: {
        Image: 'busybox',
        Name: 'test-box',
        BackoffLimit: 3
    }
}
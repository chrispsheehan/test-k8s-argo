{
  Spec(name, replicas): {
    replicas: replicas,
    selector: {
      matchLabels: {
        id: name,
      },
    },
  },
}
local Base = import "metadata.libsonnet";

{
  Spec(name): Base.Metadata((name + "-service"), name) {
    apiVersion: 'v1',
    kind: 'Service',
  },
}
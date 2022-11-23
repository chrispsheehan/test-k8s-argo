local Base = import "metadata.libsonnet";

{
  Spec(name): Base.Metadata(name, name) {
    apiVersion: 'v1',
    kind: 'Service',
  },
}
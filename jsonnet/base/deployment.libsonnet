local Base = import "metadata.libsonnet";

{
  Spec(name): Base.Metadata((name + "-deployment"), name) {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
  },
}
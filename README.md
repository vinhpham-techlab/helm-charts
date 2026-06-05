# Vinhelm charts

The charts can be added using following command:

```sh
helm repo add datalab https://vinhdata.github.io/helm-charts
```

## How to package a chart

```sh
helm package charts/vault-static-secret
helm repo index . --url https://vinhdata.github.io/helm-charts --merge index.yaml
```

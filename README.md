# Vinhelm charts

The charts can be added using following command:

```sh
helm repo add techlab-helm https://vinhpham-techlab.github.io/helm-charts
```

## How to package a chart

```sh
helm package charts/vault-static-secret
helm repo index . --url https://vinhpham-techlab.github.io/helm-charts --merge index.yaml
```

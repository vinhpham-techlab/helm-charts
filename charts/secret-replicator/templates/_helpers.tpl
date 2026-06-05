{{- define "secret-replicator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "secret-replicator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "secret-replicator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "secret-replicator.labels" -}}
helm.sh/chart: {{ include "secret-replicator.chart" . }}
{{ include "secret-replicator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "secret-replicator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "secret-replicator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "secret-replicator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "secret-replicator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "secret-replicator.sourceNamespace" -}}
{{- default .Release.Namespace .Values.source.namespace }}
{{- end }}

{{- define "secret-replicator.storeName" -}}
{{- default (printf "%s-k8s" (include "secret-replicator.sourceNamespace" .)) .Values.store.name }}
{{- end }}

{{- define "secret-replicator.caProviderNamespace" -}}
{{- default (include "secret-replicator.sourceNamespace" .) .Values.server.caProvider.namespace }}
{{- end }}

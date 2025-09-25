{{/* app.name: 루트 컨텍스트 사용 */}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* app.fullname: 루트 컨텍스트 사용 */}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "app.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* 공통 라벨: 루트 컨텍스트 사용 */}}
{{- define "app.labels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* selectorLabels: dict {"root": $root, "name": $name} 형태를 지원 */}}
{{- define "app.selectorLabels" -}}
{{- $root := .root | default . -}}
app.kubernetes.io/name: {{ include "app.name" $root }}
app.kubernetes.io/instance: {{ include "app.fullname" $root }}-{{ .name }}
{{- end -}}

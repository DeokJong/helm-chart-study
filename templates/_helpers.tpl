{{/*
- 레이블 값
- selector 라벨
- Pod template 라벨
- 컨테이너 이름, 포트 이름, metric 이름 prefix 등 "표기용 이름"
*/}}
{{- define "app.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.fullname" -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else }}
    {{- printf "%s-%s" .Release.Name (include "app.name" .) | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end -}}

{{- define "app.labels" -}}
  app.kubernetes.io/name: {{ include "app.name" . }}
  app.kubernetes.io/instance: {{ .Release.Name }}
  app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  app.kubernetes.io/managed-by: {{ .Release.Service }}
  helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end -}}

{{- define "app.selectorLabels" -}}
  app.kubernetes.io/name: {{ include "app.name" . }}
  app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

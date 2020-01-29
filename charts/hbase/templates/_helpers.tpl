{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hbase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 47 chars because some Kubernetes name fields are limited to 63 (by the DNS naming spec),
as we append -master or -region to the names
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hbase.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 47 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 47 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Standard Labels from Helm documentation https://helm.sh/docs/chart_best_practices/#labels-and-annotations
*/}}

{{- define "hbase.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: {{ .Chart.Name }}
{{- end -}}

{{/*
Create the hdfsURL.
*/}}
{{- define "hbase.hdfsURL" -}}
{{- if .Values.hdfsURL -}}
    {{- .Values.hdfsURL -}}
{{- else -}}
  {{- printf "hdfs://%s-hdfs-namenode:8020" .Release.Name }}
{{- end -}}
{{- end -}}

{{/*
Create the zookeeperURL.
*/}}
{{- define "hbase.zookeeperURL" -}}
{{- if .Values.zookeeperURL -}}
    {{- .Values.zookeeperURL -}}
{{- else -}}
  {{- printf "hdfs://%s-zookeeper:8020" .Release.Name }}
{{- end -}}
{{- end -}}
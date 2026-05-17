// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_gcp_artifact_registry_suppression.dart';

class GcpArtifactRegistryResult {
  const GcpArtifactRegistryResult({
    this.project,
    this.location,
    this.repository,
    this.packageName,
    this.versionName,
    this.format,
    this.imageSize,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? project;
  final String? location;
  final String? repository;
  final String? packageName;
  final String? versionName;
  final String? format;
  final int? imageSize;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

class GcpArtifactRegistryCallResult<T> {
  const GcpArtifactRegistryCallResult({required this.value, this.result});
  final T value;
  final GcpArtifactRegistryResult? result;
}

Future<T> tracedGcpArtifactRegistry<T>({
  required String operation,
  required Future<GcpArtifactRegistryCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (gcpArtifactRegistryInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t =
      tracer ?? OTel.tracerProvider().getTracer('otel_gcp_artifact_registry');
  final span = t.startSpan(
    'artifactregistry $operation',
    kind: SpanKind.client,
  );
  try {
    span.setStringAttribute('gcp.service', 'artifactregistry');
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.project != null) {
        span.setStringAttribute('gcp.project.id', res.project!);
      }
      if (res.location != null) {
        span.setStringAttribute('cloud.region', res.location!);
      }
      if (res.repository != null) {
        span.setStringAttribute(
          'gcp.artifactregistry.repository',
          res.repository!,
        );
      }
      if (res.packageName != null) {
        span.setStringAttribute(
          'gcp.artifactregistry.package',
          res.packageName!,
        );
      }
      if (res.versionName != null) {
        span.setStringAttribute(
          'gcp.artifactregistry.version',
          res.versionName!,
        );
      }
      if (res.format != null) {
        span.setStringAttribute('gcp.artifactregistry.format', res.format!);
      }
      if (res.imageSize != null) {
        span.setIntAttribute('container.image.size', res.imageSize!);
      }
      if (res.statusCode != null) {
        span.setIntAttribute('http.response.status_code', res.statusCode!);
      }
      if (res.errorCode != null) {
        span.setStringAttribute('artifactregistry.error.code', res.errorCode!);
      }
      final fail =
          res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.setStringAttribute(
          ErrorResource.errorType.key,
          res.errorCode ?? 'artifactregistry.error',
        );
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}

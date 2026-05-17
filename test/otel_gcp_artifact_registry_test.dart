// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:otel_gcp_artifact_registry/otel_gcp_artifact_registry.dart';
import 'package:test/test.dart';

void main() {
  group('otel_gcp_artifact_registry', () {
    test('suppression toggles in zone', () async {
      expect(gcpArtifactRegistryInstrumentationSuppressed(), isFalse);
      await runWithoutGcpArtifactRegistryInstrumentationAsync(() async {
        expect(gcpArtifactRegistryInstrumentationSuppressed(), isTrue);
      });
      expect(gcpArtifactRegistryInstrumentationSuppressed(), isFalse);
    });

    test('GcpArtifactRegistryResult fields default null', () {
      const r = GcpArtifactRegistryResult();
      expect(r.statusCode, isNull);
    });
  });
}

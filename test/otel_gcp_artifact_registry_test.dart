// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

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

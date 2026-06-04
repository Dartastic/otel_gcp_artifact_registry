// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'dart:async';

const _key = #dartastic_otel_libs_gcpArtifactRegistry_suppress;

bool gcpArtifactRegistryInstrumentationSuppressed() =>
    Zone.current[_key] == true;

T runWithoutGcpArtifactRegistryInstrumentation<T>(T Function() body) =>
    runZoned(body, zoneValues: {_key: true});

Future<T> runWithoutGcpArtifactRegistryInstrumentationAsync<T>(
  Future<T> Function() body,
) =>
    runZoned(body, zoneValues: {_key: true});

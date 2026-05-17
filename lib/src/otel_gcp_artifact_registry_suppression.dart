// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'dart:async';

const _key = #dartastic_otel_libs_gcpArtifactRegistry_suppress;

bool gcpArtifactRegistryInstrumentationSuppressed() =>
    Zone.current[_key] == true;

T runWithoutGcpArtifactRegistryInstrumentation<T>(T Function() body) =>
    runZoned(body, zoneValues: {_key: true});

Future<T> runWithoutGcpArtifactRegistryInstrumentationAsync<T>(
  Future<T> Function() body,
) => runZoned(body, zoneValues: {_key: true});

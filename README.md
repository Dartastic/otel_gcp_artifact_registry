# otel_gcp_artifact_registry

Dartastic OpenTelemetry bridge for GCP Artifact Registry (containers + packages).

Wraps each call in a CLIENT-kind span with vendor-specific attributes following OpenTelemetry semantic conventions where applicable.

```dart
import 'package:otel_gcp_artifact_registry/otel_gcp_artifact_registry.dart';

await tracedGcpArtifactRegistry<void>(
  operation: 'someOp',
  invoke: () async {
    final r = await client.someOp();
    return GcpArtifactRegistryCallResult(value: r, result: GcpArtifactRegistryResult(statusCode: 200));
  },
);
```

Suppress instrumentation within a block:

```dart
await runWithoutGcpArtifactRegistryInstrumentationAsync(() async {
  await client.someInternalSync();
});
```

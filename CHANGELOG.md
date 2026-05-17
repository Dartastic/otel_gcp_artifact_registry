# Changelog

## [0.1.0-beta.1-wip]

### Added

- Initial release.
- `tracedGcpArtifactRegistry<T>(...)` — wraps a otel_gcp_artifact_registry call in a CLIENT-kind span
  with vendor-specific attributes.
- Zone-scoped suppression via `runWithoutGcpArtifactRegistryInstrumentation()` / `Async()`.

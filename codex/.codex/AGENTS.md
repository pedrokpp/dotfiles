# Global coding guidelines

## Design principles

- Apply SOLID principles when they improve cohesion, reduce coupling, or make change safer. Do not introduce abstractions only to satisfy a principle mechanically.
- Follow DRY for stable knowledge and behavior. Do not merge code that is merely similar but may evolve independently.
- Prefer the simplest design that satisfies the current requirements.
- Do not add features, extension points, configuration, or abstractions for hypothetical future needs.
- Preserve the existing architecture and conventions unless the task requires changing them.
- Keep changes focused. Avoid unrelated refactors.

## Validation

- For every proposed or implemented code change, identify the expected behavior and provide a concrete way to validate it.
- Prefer automated tests. Use unit tests for isolated behavior and integration tests for interactions between components or external boundaries.
- When implementing a change, add or update the relevant tests when practical and run the most relevant checks available in the repository.
- If an automated test is not practical, provide specific manual verification steps and explain what result confirms success.
- Report which validations were run, their results, and any checks that could not be run.

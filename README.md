## Installation

1. Clone this repo.
2. Copy ODbeta toolchain compressed distribution package to root of the cloned repo. The name of the package must be `opendingux-gcw0-toolchain.*.tar.xz`.
3. With Docker installed and running, `make shell` builds the toolchain and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default. The `CROSS_COMPILE` and `PATH` env vars have been updated with the toolchain location.

After building the first time, `make shell` will skip building and drop into the shell.

## Workflow

- On your host machine, clone repositories into `./workspace` and make changes as usual.
- In the container shell, find the repository in `~/workspace` and build as usual.
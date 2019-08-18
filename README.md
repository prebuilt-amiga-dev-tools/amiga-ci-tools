
# Amiga build tools in a Docker container

This container contains a set of common tools that are needed when building 68000 code for CI purposes.

You will find programs like make, vasm, vlink, testrunner-68k and various support tools within.

## Usage with CircleCI

Here is an example `.circleci/config.yml` file:

```yaml
version: 2
jobs:
  build:
    docker:
      - image: amigacitools/amiga-ci-tools:latest
    steps:
      - checkout
      - run: make test
      - store_test_results:
          path: ./junit	  
      - store_artifacts:
          path: ./junit
```
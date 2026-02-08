# AWS CLI v2 Installation on macOS

## Date

2026-02-08

## Overview

Installation of AWS CLI v2 on macOS (Darwin 22.6.0, arm64) using Homebrew.

## Prerequisites

- macOS with Homebrew installed
- Homebrew version used: 5.0.13

## Pre-installation State

- A broken AWS CLI v1 symlink existed at `/usr/local/bin/aws` pointing to
  `/usr/local/aws/bin/aws` (Python-based, non-functional)
- No working `aws` command was available

## Installation Steps

### 1. Install AWS CLI v2 via Homebrew

```bash
brew install awscli
```

### 2. Dependencies Installed

Since macOS 13 (Ventura) is Tier 3 for Homebrew, most packages were built
from source rather than using pre-built bottles:

| Dependency    | Version    | Notes            |
|---------------|------------|------------------|
| cmake         | 4.2.3      | Built from source |
| ca-certificates | 2025-12-02 | Pre-built bottle |
| openssl@3     | 3.6.1      | Built from source |
| sqlite        | 3.51.2_1   | Built from source |
| xz            | 5.8.2      | Built from source |
| pkgconf       | 2.5.1      | Pre-built bottle  |
| lzip          | 1.25       | Pre-built bottle  |
| expat         | 2.7.4      | Built from source |
| python@3.13   | 3.13.12_1  | Built from source |

### 3. Installed Version

```
aws-cli/2.33.17 Python/3.13.12 Darwin/22.6.0 source/arm64
```

## Installation Paths

| Item | Path |
|------|------|
| AWS CLI binary | `/opt/homebrew/bin/aws` |
| AWS CLI Cellar | `/opt/homebrew/Cellar/awscli/2.33.17` |
| Examples | `/opt/homebrew/share/awscli/examples` |
| Zsh completions | `/opt/homebrew/share/zsh/site-functions` |

## Known Issues

### Broken old AWS CLI v1 symlink

A broken symlink exists at `/usr/local/bin/aws` -> `/usr/local/aws/bin/aws`
from a previous AWS CLI v1 installation. This causes a harmless error message
when running `aws` commands:

```
(eval):1: /usr/local/bin/aws: bad interpreter: /usr/local/aws/bin/python: no such file or directory
```

The Homebrew-installed binary at `/opt/homebrew/bin/aws` works correctly.
To clean this up, remove the old symlink:

```bash
sudo rm /usr/local/bin/aws
```

### openssl@3 post-install warning

The openssl@3 post-install step did not complete successfully. This does not
affect AWS CLI functionality. Can be retried with:

```bash
brew postinstall openssl@3
```

## Verification

```bash
# Check version
aws --version

# Check binary location
which aws
# Expected: /opt/homebrew/bin/aws (after removing old symlink)
```

## Common Management Commands

```bash
# Update AWS CLI
brew upgrade awscli

# Uninstall AWS CLI
brew uninstall awscli

# Configure AWS credentials
aws configure
```

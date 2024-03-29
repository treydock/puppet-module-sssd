# puppet-module-sssd

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/sssd.svg)](https://forge.puppetlabs.com/treydock/sssd)
[![CI Status](https://github.com/treydock/puppet-module-sssd/workflows/CI/badge.svg?branch=master)](https://github.com/treydock/puppet-module-sssd/actions?query=workflow%3ACI)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)

## Overview

This module manages SSSD.

## Usage

### sssd

```puppet
include sssd
```

Hiera of a working SSSD deployment

```yaml
sssd::configs:
  sssd:
    debug_level: 0x02F0
    domains: LDAP
    services:
      - pam
      - nss
  nss:
    debug_level: 0x02F0
    filter_groups:
      - root
      - wheel
    filter_users:
      - root
  pam:
    debug_level: 0x02F0
  domain/LDAP:
    cache_credentials: true
    debug_level: 0x02F0
    enumerate: false
    id_provider: ldap
    auth_provider: ldap
    chpass_provider: ldap
    access_provider: ldap
    ldap_uri:
      - ldaps://ldap1.example.com:636
      - ldaps://ldap2.example.com:636
    ldap_search_base: 'dc=example,dc=com'
    ldap_schema: rfc2307
    ldap_tls_reqcert: demand
    ldap_access_filter: '(&(objectClass=shadowAccount)(objectClass=posixAccount))'
    ldap_access_order:
      - filter
      - expire
    ldap_pwd_policy: shadow
    ldap_account_expire_policy: shadow
    ldap_group_member: memberuid
```

## Reference

[http://treydock.github.io/puppet-module-sssd/](http://treydock.github.io/puppet-module-sssd/)

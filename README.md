# puppet-module-sssd

[![Build Status](https://travis-ci.org/treydock/puppet-module-sssd.png)](https://travis-ci.org/treydock/puppet-module-sssd)

####Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)
6. [TODO](#todo)
7. [Additional Information](#additional-information)

## Overview



## Usage

### sssd

    include sssd

Hiera of a working SSSD deployment

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


## Reference

### Classes

#### Public classes

* `sssd`: Installs and configures sssd.

#### Private classes

* `sssd::install`: Installs sssd packages.
* `sssd::config`: Configures sssd.
* `sssd::service`: Manages the sssd service.
* `sssd::params`: Sets parameter defaults based on fact values.

### Parameters

#### sssd

#####`configs`

Hash that configurations that will be used in /etc/sssd/sssd.conf.  Arrays will be joined by commas, all other values are passed as-is.

## Limitations

This module has been tested on:

* RedHat 6 x86_64
* RedHat 7 x86_64

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker

## TODO

## Further Information

*

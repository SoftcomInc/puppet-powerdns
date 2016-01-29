# == Class: powerdns
#
# === Authors
#
# Christian Gonzalez <christiangda@gmail.com>
#
# === Copyright
#
# Copyright 2016 Christian Gonzalez.
#
class powerdns (
  $package_ensure     = $::powerdns::params::package_ensure,
  $service_enable     = $::powerdns::params::service_enable,
  $service_ensure     = $::powerdns::params::service_ensure,
  $service_manage     = $::powerdns::params::service_manage,
  $service_restart    = $::powerdns::params::service_restart,
  $service_status     = $::powerdns::params::service_status,
  $service_status_cmd = $::powerdns::params::service_status_cmd,
  $config_file_path   = $::powerdns::params::config_file_path,
  $config_file        = $::powerdns::params::config_file,
  $config_file_backup = $::powerdns::params::config_file_backup,
  $config             = {},
  ) inherits powerdns::params {

  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  if ! ($package_ensure in [ 'present', 'installed', 'absent', 'purged', 'held', 'latest' ]) {
    fail("\"${::status}\" is not a valid status parameter value")
  }

  validate_bool($service_enable)
  validate_bool($service_manage)

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail("\"${::status}\" is not a valid status parameter value")
  }

  validate_string($config_file_path)
  validate_string($config_file)
  validate_bool($config_file_backup)
  validate_hash($config)

  $package_name = $::powerdns::params::package_name
  validate_array($package_name)

  $service_name = $::powerdns::params::service_name
  validate_string($service_name)
  validate_bool($service_restart)
  validate_bool($service_status)

  # Variable used to merge configd
  $config_options = merge($::powerdns::params::default_config, $config)

  ::powerdns::install { $package_name: } ->
  ::powerdns::config { $config_file:
    values       => $config_options,
    file_path    => $config_file_path,
    service_name => $service_name,
  } ->
  ::powerdns::service { $service_name:
    service_restart    => $service_restart,
    service_status     => $service_status,
    service_status_cmd => $service_status_cmd,
  }
}

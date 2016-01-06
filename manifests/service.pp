#
class powerdns::service (
    $service_name   = undef,
    $service_ensure = 'running',
    $service_enable = true,
    $service_manage = true,
  ) {

  if $service_manage == true {
    service { 'pdns':,
      ensure     => $service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['powerdns::install']
    }
  }
}

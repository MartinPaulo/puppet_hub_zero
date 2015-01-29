# Could perhaps be done with pgp key? http://budts.be/weblog/2012/08/ssh-authentication-with-your-pgp-key
class v3::admins {

# for each potential admin, copy the the section below up to the '========================' line and customize.

  user { 'martin':
    comment => 'mpaulo@v3.org.au',
    ensure  => present,
    groups  => 'sudo',
  }

# hubzero_sup
# generated by:  ssh-keygen -t rsa -C "mpaulo@v3.org.au" then copying the public portion to the key below.
  ssh_authorized_key { 'mpaulo@v3.org.au':
    user    => 'martin',
    ensure  => present,
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDMW4zLFHV0j8GgVG/5yebcs95gaCBwgv+YfTLAok/dY77LoqVGhw+4vP3A03qnc0l08Dq5BJz8x6i4JSmUgYS+tMh7MIopR6VsG3jDwt7cViJUKicWEUCwF0M8RRtdLAtVvbv3o3DrhLcEqzpGE4yO3wIYkFzFvU+wmoA4IJt95ZK3z/VXtljUs4bB8XeYfAf+gGei/y9sNcn5388LDr5Wkqay/2fXmllC7yAxeNdD5pOsDI1/xwFBYCG5wmatsJvKL5zpWQPm1LWQ0uCPZzn40t5KsFGE5puxs6uvVSpmn3k/u7qlMfYhpDIXhn63yw9Kzi9qL2PFVsbmk7Y6Z+qp',
    type    => 'rsa',
    require => File['/home/martin/.ssh'],
  }

  file { '/home/martin':
    ensure => 'directory',
    owner  => 'martin'
  }

  file { '/home/martin/.ssh':
    ensure => 'directory',
    owner  => 'martin',
    mode   => '0700',
  }

#'========================'

  file { '/etc/sudoers.d/sudogroup':
    ensure => file,
    owner  => root,
    mode   => '0440',
    source => 'puppet:///modules/tdar/sudogroup',
  }
}

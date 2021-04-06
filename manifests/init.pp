class k8_module {
    service { 'firewalld':
        enable => false,
        ensure => stopped,
    }
    exec { 'disable swap':
      path    => ['/usr/sbin/', '/usr/bin', '/bin', '/sbin'],
      command => 'swapoff -a',
      unless  => "awk '{ if (NR > 1) exit 1}' /proc/swaps",
    }
    file_line { 'remove swap in /etc/fstab':
      ensure            => absent,
      path              => '/etc/fstab',
      match             => '\sswap\s',
      match_for_absence => true,
      multiple          => true,
    } 
    class { selinux:
        mode => 'disabled',
        type => 'targeted',
    }
	package { ['kubeadm', 'kubelet', 'kubectl']:
		ensure => 'present'
	}
	file { '/etc/sysctl.d/kubernetes.conf':
        ensure => file,
        content => template('k8_module/conf.erb'),
    }
	file { '/etc/yum.repos.d/kubernetes.repo':
        ensure => file,
        content => template('k8_module/repo.erb'),
    }
}

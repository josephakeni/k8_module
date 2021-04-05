class k8_module {
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

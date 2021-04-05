class kubernetes {
	package { ['kubeadm', 'kubelet', 'kubectl']:
		ensure => 'present'
	}
	file { '/etc/yum.repos.d/kubernetes.repo':
        ensure => file,
        content => template('k8_module/repo.erb'),

    }
}

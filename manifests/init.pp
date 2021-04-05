class kubernetes {
	package { ['kubeadm', 'kubelet', 'kubectl']:
		ensure => 'present'
	}
}

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Feb 2018 11:05:54 +0000
Subject: [PATCH v4 02/40] KVM: arm/arm64: Move vcpu_load call after
 kvm_vcpu_first_run_init
In-Reply-To: <20180215210332.8648-3-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-3-christoffer.dall@linaro.org>
Message-ID: <86h8qali0d.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 21:02:54 +0000,
Christoffer Dall wrote:
> 
> Moving the call to vcpu_load() in kvm_arch_vcpu_ioctl_run() to after
> we've called kvm_vcpu_first_run_init() simplifies some of the vgic and
> there is also no need to do vcpu_load() for things such as handling the
> immediate_exit flag.
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.

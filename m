From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Dec 2017 17:30:03 +0000
Subject: [PATCH v2 05/36] KVM: arm/arm64: Add kvm_vcpu_load_sysregs and
 kvm_vcpu_put_sysregs
In-Reply-To: <20171207170630.592-6-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-6-christoffer.dall@linaro.org>
Message-ID: <86609fstb8.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Dec 2017 17:05:59 +0000,
Christoffer Dall wrote:
> 
> As we are about to move a bunch of save/restore logic for VHE kernels to
> the load and put functions, we need some infrastructure to do this.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.

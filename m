From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 17:13:35 +0000
Subject: [PATCH v2 07/12] KVM: arm/arm64: simplify vgic_find_range() and
 callers
In-Reply-To: <1427126309-11223-8-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-8-git-send-email-andre.przywara@arm.com>
Message-ID: <5512ECBF.9030800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:58, Andre Przywara wrote:
> The vgic_find_range() function in vgic.c takes a struct kvm_exit_mmio
> argument, but actually only used the length field in there. Since we
> need to get rid of that structure in that part of the code anyway,
> let's rework the function (and it's callers) to pass the length
> argument to the function directly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

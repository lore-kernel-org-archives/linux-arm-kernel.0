From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 May 2016 11:22:24 +0100
Subject: [PATCH v3 20/55] KVM: arm/arm64: vgic-new: Implement
 kvm_vgic_vcpu_pending_irq
In-Reply-To: <1462531568-9799-21-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-21-git-send-email-andre.przywara@arm.com>
Message-ID: <5731B660.4030400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Eric Auger <eric.auger@linaro.org>
> 
> Tell KVM whether a particular VCPU has an IRQ that needs handling
> in the guest. This is used to decide whether a VCPU is runnable.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

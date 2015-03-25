From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 16:56:34 +0000
Subject: [PATCH v2 01/12] KVM: Redesign kvm_io_bus_ API to pass VCPU
 structure to the callbacks.
In-Reply-To: <1427126309-11223-2-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-2-git-send-email-andre.przywara@arm.com>
Message-ID: <5512E8C2.9010708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:58, Andre Przywara wrote:
> From: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> 
> This is needed in e.g. ARM vGIC emulation, where the MMIO handling
> depends on the VCPU that does the access.
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

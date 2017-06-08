From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Jun 2017 15:14:37 +0100
Subject: [PATCH v3 8/9] KVM: arm/arm64: Disallow userspace control of
 in-kernel IRQ lines
In-Reply-To: <20170608133446.3875-9-cdall@linaro.org> (Christoffer Dall's
 message of "Thu, 8 Jun 2017 15:34:45 +0200")
References: <20170608133446.3875-1-cdall@linaro.org>
 <20170608133446.3875-9-cdall@linaro.org>
Message-ID: <8737bain1u.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08 2017 at  3:34:45 pm BST, Christoffer Dall <cdall@linaro.org> wrote:
> When injecting an IRQ to the VGIC, you now have to present an owner
> token for that IRQ line to show that you are the owner of that line.
>
> IRQ lines driven from userspace or via an irqfd do not have an owner and
> will simply pass a NULL pointer.
>
> Also get rid of the unused kvm_vgic_inject_mapped_irq prototype.
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.

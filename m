From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Nov 2011 13:19:20 +0000
Subject: [GIT PULL] VIC DT+MULTI_IRQ_HANDLER patches
In-Reply-To: <20111111123007.GD5114@totoro>
References: <20111111123007.GD5114@totoro>
Message-ID: <4EBD20D8.7080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/11 12:30, Jamie Iles wrote:

Hi Jamie,

> I've updated the VIC series to include export.h and added some Tested-by 
> and Acked-by's.
> 
> This is dependent on https://lkml.org/lkml/2011/11/10/186 (irq: fix 
> possible null-pointer deref irq_domain_to_irq) which hasn't been picked 
> up yet so I understand if you don't want to hold up your GIC patches, 
> but I'll defer to you on that!

Pulled, thanks. I expect the irq_domain fix to be picked up very soon,
and it should reach mainline quickly enough.

Resulting merge is at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irqchip-consolidation

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...

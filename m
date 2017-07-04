From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 4 Jul 2017 11:12:27 +0100
Subject: [PATCH 0/3] irqchip: Miscellaneous fixes for GIC/GICv3
In-Reply-To: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
References: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <a3f2e4f2-bea1-5abc-ae17-3fa4822acd2e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/17 10:56, Suzuki K Poulose wrote:
> This series contains some fixes for GIC/GIC-v3 to behave as expected
> by the generic management layer.
> 
> Suzuki K Poulose (3):
>   irqchip: gic-v3: Report failures in gic_irq_domain_alloc
>   irqchip: gic-v2: Report failures in gic_irq_domain_alloc
>   irq: gic-v3: Honor forced affinity setting
> 
>  drivers/irqchip/irq-gic-v3.c | 14 +++++++++++---
>  drivers/irqchip/irq-gic.c    |  7 +++++--
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 

All 3 patches queued for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

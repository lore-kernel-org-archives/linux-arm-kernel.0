From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Oct 2018 10:24:00 +0100
Subject: [PATCH v5 08/27] irqchip/gic: Unify GIC priority definitions
In-Reply-To: <1535471497-38854-9-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-9-git-send-email-julien.thierry@arm.com>
Message-ID: <eb1b6e2a-cffc-adc7-d0ff-2ed21919ea80@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/18 16:51, Julien Thierry wrote:
> LPIs use the same priority value as other GIC interrupts.
> 
> Make the GIC default priority definition visible to ITS implementation
> and use this same definition for LPI priorities.
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c       | 2 +-
>   include/linux/irqchip/arm-gic-common.h | 6 ++++++
>   include/linux/irqchip/arm-gic.h        | 5 -----
>   3 files changed, 7 insertions(+), 6 deletions(-)

I've cherry-picked this for 4.20, as this is a good cleanup.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

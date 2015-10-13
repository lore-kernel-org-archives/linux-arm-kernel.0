From: joel@porquet.org (Joel Porquet)
Date: Tue, 13 Oct 2015 14:15:59 +0000 (UTC)
Subject: [PATCH] ARM: Remove open-coded version of
 =?utf-8?b?SVJRQ0hJUF9ERUNMQVJF?=
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <loom.20151013T161004-793@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier <at> arm.com> writes:

> 
> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
> it becomes possible to cleanup the open-coded versions of the same
> macro that have been added to some private irqchips implementations.
> 
> Cc: Kukjin Kim <kgene <at> kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski <at> samsung.com>
> Cc: Shawn Guo <shawnguo <at> kernel.org>
> Cc: Sascha Hauer <kernel <at> pengutronix.de>
> Cc: Tony Lindgren <tony <at> atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier <at> arm.com>
> ---
>  arch/arm/mach-exynos/suspend.c       | 3 ++-
>  arch/arm/mach-imx/gpc.c              | 8 ++------
>  arch/arm/mach-omap2/omap-wakeupgen.c | 8 ++------
>  3 files changed, 6 insertions(+), 13 deletions(-)

I had suggested the same patch a few months ago
(https://lkml.org/lkml/2015/7/7/1069) but without success although it had
been acked by everybody :/
I didn't know how to have it pushed all at once...

Suggested-by: Joel Porquet <joel@porquet.org>

Thanks,
Jo?l

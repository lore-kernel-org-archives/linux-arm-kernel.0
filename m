From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Oct 2015 14:49:05 +0800
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151008064905.GC22673@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 05:24:17PM +0100, Marc Zyngier wrote:
> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
> it becomes possible to cleanup the open-coded versions of the same
> macro that have been added to some private irqchips implementations.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
...
>  arch/arm/mach-imx/gpc.c              | 8 ++------

Acked-by: Shawn Guo <shawnguo@kernel.org>

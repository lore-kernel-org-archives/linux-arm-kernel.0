From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 09:53:05 -0700
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <1445005270-18715-1-git-send-email-marc.zyngier@arm.com>
References: <1445005270-18715-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151022165305.GC19953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 03:21:10PM +0100, Marc Zyngier wrote:
> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
> it becomes possible to cleanup the open-coded versions of the same
> macro that have been added to some private irqchips implementations.
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Acked-by: Kukjin Kim <kgene@kernel.org>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied to next/cleanup. Thanks!

-Olof

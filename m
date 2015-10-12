From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 13:47:59 -0700
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151012204759.GU23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [151002 09:28]:
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

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>

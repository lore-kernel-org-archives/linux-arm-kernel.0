From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:39:56 -0800
Subject: [PATCH 04/16] ARM: omap: fix prm44xx.c OMAP44XX_IRQ_PRCM build
 error
In-Reply-To: <E1RvAW4-0006Gy-S6@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAW4-0006Gy-S6@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208183951.GD29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)

Can you please add something like "This happens when CONFIG_OF is
not selected".
 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>

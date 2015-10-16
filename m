From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 11:22:09 -0500
Subject: [PATCH 10/11] arm: omap2+: select 32k clocksource driver
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Message-ID: <1445012530-14126-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a 32k clocksource driver, let's
select it for OMAP2PLUS builds.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b3a0dff67e3f..dc793cc60965 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -96,6 +96,7 @@ config ARCH_OMAP2PLUS
 	select SOC_BUS
 	select TI_PRIV_EDMA
 	select OMAP_IRQCHIP
+	select CLKSRC_TI_32K
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
 
-- 
2.5.3

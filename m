From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 12 Sep 2013 21:09:11 +0530
Subject: [RFC PATCH 4/4] ARM: DRA: Kconfig: Enable crossbar irqchip driver for
 DRA7xx
In-Reply-To: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1379000351-15672-5-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the crossbar irqchip driver for DRA7xx soc.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8413252..b602168 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -120,6 +120,7 @@ config SOC_DRA7XX
 	select ARM_GIC
 	select HAVE_SMP
 	select COMMON_CLK
+	select IRQCHIP_CROSSBAR
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.9.5

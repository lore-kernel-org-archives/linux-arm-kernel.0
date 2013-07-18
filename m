From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 18 Jul 2013 22:13:50 +0530
Subject: [PATCH 3/3] ARM: DRA7xx: Enable crossbar driver for the soc
In-Reply-To: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1374165830-6367-4-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the crossbar driver to handle the irq/dma
crossbar devices in the soc.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 80aaadc..3def350 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -120,6 +120,7 @@ config SOC_DRA7XX
 	select ARM_GIC
 	select HAVE_SMP
 	select COMMON_CLK
+	select CROSSBAR
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.9.5

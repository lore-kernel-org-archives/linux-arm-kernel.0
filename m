From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 17:43:25 +0200
Subject: [PATCH 1/2] MAINTAINERS: add new entries for Armada 8K cpufreq driver
Message-ID: <20180921154326.10776-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new driver belongs to the mvebu family, update the MAINTAINER file
to document it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..7e969fbb3626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1657,6 +1657,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	drivers/cpufreq/armada-37xx-cpufreq.c
+F!	drivers/cpufreq/armada-8k-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c
 F:	drivers/irqchip/irq-armada-370-xp.c
 F:	drivers/irqchip/irq-mvebu-*
-- 
2.19.0

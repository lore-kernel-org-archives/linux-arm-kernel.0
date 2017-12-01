From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  1 Dec 2017 12:25:06 +0100
Subject: [PATCH 4/6] MAINTAINERS: add new entries for Armada 37xx cpufreq
 driver
In-Reply-To: <20171201112508.14121-1-gregory.clement@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Message-ID: <20171201112508.14121-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new driver belongs to the mvebu family, update the MAINTAINER file
to document it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..98dcee849481 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1582,6 +1582,7 @@ F:	arch/arm/boot/dts/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
+F:	drivers/cpufreq/armada-37xx-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c
 F:	drivers/irqchip/irq-armada-370-xp.c
 F:	drivers/irqchip/irq-mvebu-*
-- 
2.15.0

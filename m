From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Dec 2017 18:51:17 +0100
Subject: [PATCH v3 2/4] MAINTAINERS: add new entries for Armada 37xx cpufreq
 driver
In-Reply-To: <20171213175119.9441-1-gregory.clement@free-electrons.com>
References: <20171213175119.9441-1-gregory.clement@free-electrons.com>
Message-ID: <20171213175119.9441-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new driver belongs to the mvebu family, update the MAINTAINER file
to document it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
2.15.1

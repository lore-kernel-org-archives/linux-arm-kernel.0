From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 14:58:53 +0200
Subject: [PATCH 2/2] MAINTAINERS: add irqchip related drivers to Marvell EBU
 maintainers
In-Reply-To: <1495112333-10494-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1495112333-10494-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1495112333-10494-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the MAINTAINERS file so that the Marvell EBU
maintainers are also responsible for their irqchip drivers in
drivers/irqchip/.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2725ea3..52ae170 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,6 +1496,8 @@ F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	drivers/cpufreq/mvebu-cpufreq.c
+F:	drivers/irqchip/irq-armada-370-xp.c
+F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/rtc/rtc-armada38x.c
 
 ARM/Marvell Berlin SoC support
-- 
2.7.4

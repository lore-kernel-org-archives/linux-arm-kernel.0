From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 15 Sep 2017 15:57:08 +0800
Subject: [PATCH] MAINTAINERS: Marvell berlin is now Synaptics berlin
Message-ID: <20170915155708.1f09cc85@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that the dts files are moved to the new location, update the berlin
entry in the MAINTAINERS.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 209306019483..d0854bc98f24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,15 +1530,6 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
-ARM/Marvell Berlin SoC support
-M:	Jisheng Zhang <jszhang@marvell.com>
-M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-berlin/
-F:	arch/arm/boot/dts/berlin*
-F:	arch/arm64/boot/dts/marvell/berlin*
-
 ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
@@ -1933,6 +1924,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
 N:	stm32
 F:	drivers/clocksource/armv7m_systick.c
 
+ARM/Synaptics Berlin SoC support
+M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-berlin/
+F:	arch/arm/boot/dts/berlin*
+F:	arch/arm64/boot/dts/synaptics/berlin*
+
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
 L:	linux-arm-kernel at lists.infradead.org
-- 
2.14.1

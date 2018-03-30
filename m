From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 30 Mar 2018 11:02:11 +0800
Subject: [PATCH v2] MAINTAINERS: update entry for ARM/berlin
Message-ID: <20180330110211.36455347@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
So change the berlin entry name and move it to its alphabetical
location. We move to ARM/Synaptics instead of ARM/Marvell.

This patch also updates my email address from marvell to synaptics.

[1] https://www.synaptics.com/company/news/conexant-marvell

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - add some comments about this change. Thank Andrew.

 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e950b8b4a41..0a0da6a8e607 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,15 +1578,6 @@ ARM/MAGICIAN MACHINE SUPPORT
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
@@ -2006,6 +1997,15 @@ F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
 
+ARM/Synaptics Berlin SoC support
+M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-berlin/
+F:	arch/arm/boot/dts/berlin*
+F:	arch/arm64/boot/dts/marvell/berlin*
+
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
 M:	Mans Rullgard <mans@mansr.com>
-- 
2.16.3

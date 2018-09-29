From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Sat, 29 Sep 2018 13:00:03 +0800
Subject: [PATCH] MAINTAINERS: fix pattern in ARM/Synaptics berlin SoC section
Message-ID: <20180929130003.5dc79bed@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin SoC files has been moved from marvell dir to synaptics dir, but
commit bc52497a595d ("MAINTAINERS: update entry for ARM/berlin") didn't
update the dir accordingly. This patch fixes it.

>From another side, new derivative SoCs from Synaptics may not be named
as berlin*, so let's update the entries accordingly.

Fixes: bc52497a595d ("MAINTAINERS: update entry for ARM/berlin")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reported-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a255240d1452..2be912b67905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,14 +2093,14 @@ F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
 
-ARM/Synaptics Berlin SoC support
+ARM/Synaptics SoC support
 M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-berlin/
 F:	arch/arm/boot/dts/berlin*
-F:	arch/arm64/boot/dts/marvell/berlin*
+F:	arch/arm64/boot/dts/synaptics/
 
 ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc.w.gonzalez@free.fr>
-- 
2.19.0

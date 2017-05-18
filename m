From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 14:58:52 +0200
Subject: [PATCH 1/2] MAINTAINERS: sort F entries for Marvell EBU maintainers
Message-ID: <1495112333-10494-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit sorts alphabetically the file entries of the Marvell EBU
maintainers in the MAINTAINERS file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b..2725ea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,13 +1490,13 @@ M:	Gregory Clement <gregory.clement@free-electrons.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/mach-mvebu/
-F:	drivers/rtc/rtc-armada38x.c
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
+F:	arch/arm/configs/mvebu_*_defconfig
+F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	drivers/cpufreq/mvebu-cpufreq.c
-F:	arch/arm/configs/mvebu_*_defconfig
+F:	drivers/rtc/rtc-armada38x.c
 
 ARM/Marvell Berlin SoC support
 M:	Jisheng Zhang <jszhang@marvell.com>
-- 
2.7.4

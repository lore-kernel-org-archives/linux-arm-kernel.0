From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Mar 2016 09:27:06 +0100
Subject: [PATCH] MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig to
 relevant maintainers
Message-ID: <1458289626-26153-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm/configs/mvebu_*_defconfig currently don't belong to any
maintainer, so get_maintainer returns only information based on
commits, which is not completely accurate.

Therefore, this commit replaces a useless empty newline in MAINTAINERS
by a line attaching those defconfigs to the appropriate Marvell EBU
maintainers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ee06ea..c91ad96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1285,7 +1285,7 @@ F:	arch/arm/mach-mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
-
+F:	arch/arm/configs/mvebu_*_defconfig
 
 ARM/Marvell Berlin SoC support
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
-- 
2.6.4

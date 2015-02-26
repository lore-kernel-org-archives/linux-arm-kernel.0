From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Feb 2015 19:18:43 +0100
Subject: [PATCH v2 RESEND] MAINTAINERS: Add dts entries for some of the
 Marvell SoCs
Message-ID: <1424974723-17429-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since many releases, the modifications of the mvebu and berlin device
tree files are merged through the mvebu subsystem. This patch makes it
official in order to help the contributors using the get_maintainer.pl
to find the accurate peoples.

In the same time, updated the mvebu description which now includes the
kirkwood SoCs and new Armada SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
Hi Olof and Arnd,

would you mind taking this patch in arm-soc?

Thanks!


 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8cf9a8a..40c96e6209b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1168,7 +1168,7 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
-ARM/Marvell Armada 370 and Armada XP SOC support
+ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@free-electrons.com>
@@ -1177,12 +1177,15 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mvebu/
 F:	drivers/rtc/armada38x-rtc
+F:	arch/arm/boot/dts/armada*
+F:	arch/arm/boot/dts/kirkwood*
 
 ARM/Marvell Berlin SoC support
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-berlin/
+F:	arch/arm/boot/dts/berlin*
 
 ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
@@ -1194,6 +1197,8 @@ F:	arch/arm/mach-dove/
 F:	arch/arm/mach-mv78xx0/
 F:	arch/arm/mach-orion5x/
 F:	arch/arm/plat-orion/
+F:	arch/arm/boot/dts/dove*
+F:	arch/arm/boot/dts/orion5x*
 
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
-- 
2.1.0

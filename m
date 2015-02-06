From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  6 Feb 2015 13:30:10 +0100
Subject: [PATCH] MAINTAINERS: Add dts entries for mvebu and dove
Message-ID: <1423225810-5504-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since many releases, the modifications of the mvebu device tree files
are merged through the mvebu subsystem. This patch makes it official
in order to help the contributors using the get_maintainer.pl to find
the accurate people.

In the same time, updated the mvebu description which now includes the
kirkwood SoCs and new Armada SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi Jason, Andrew and Sebastian

This last patch [1] showed that if people follow the recommendation to
submit patch (using get_maintainer.pl script), we don't receive
them. So I propose to amend MAINTAINERS with this patch.

What do you think about it?

If you agree then we can merged it in our next-merge windows (3.21).

Thanks,

Gregory

[1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/109387



 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d9db6b445bc..d96daf53533c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1149,7 +1149,7 @@ ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
-ARM/Marvell Armada 370 and Armada XP SOC support
+ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@free-electrons.com>
@@ -1158,6 +1158,8 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-mvebu/
 F:	drivers/rtc/armada38x-rtc
+F:	arch/arm/boot/dts/armada*.dts
+F:	arch/arm/boot/dts/kirkwood*.dts
 
 ARM/Marvell Berlin SoC support
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
@@ -1175,6 +1177,7 @@ F:	arch/arm/mach-dove/
 F:	arch/arm/mach-mv78xx0/
 F:	arch/arm/mach-orion5x/
 F:	arch/arm/plat-orion/
+F:	arch/arm/boot/dts/dove*.dts
 
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
-- 
2.1.0

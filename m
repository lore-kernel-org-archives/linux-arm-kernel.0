From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 22:08:48 +0200
Subject: [PATCH v2 3/5] ARM: dts: dove: Remove Compulab CM-A510 from Makefile
In-Reply-To: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430770130-7833-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior reworking Dove based Compulab CM-A510 device tree, remove it
from the compiled device tree files.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: arm at kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db2937a..dc24597c4f2e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -649,7 +649,6 @@ dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-openblocks-ax3-4.dtb \
 	armada-xp-synology-ds414.dtb
 dtb-$(CONFIG_MACH_DOVE) += \
-	dove-cm-a510.dtb \
 	dove-cubox.dtb \
 	dove-cubox-es.dtb \
 	dove-d2plug.dtb \
-- 
2.1.0

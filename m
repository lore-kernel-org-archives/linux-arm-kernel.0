From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 22:08:50 +0200
Subject: [PATCH v2 5/5] ARM: dts: dove: Add Compulab SBC-A510 to Makefile
In-Reply-To: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430770130-7833-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With reworked device tree files for Compulab CM-A510 SoM and SBC-A510
base board, now add the correspoding board file to Makefile again.

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
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dc24597c4f2e..ba72134f1fd3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -653,7 +653,8 @@ dtb-$(CONFIG_MACH_DOVE) += \
 	dove-cubox-es.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
-	dove-dove-db.dtb
+	dove-dove-db.dtb \
+	dove-sbc-a510.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
-- 
2.1.0

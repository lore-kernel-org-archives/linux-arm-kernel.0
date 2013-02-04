From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 4 Feb 2013 14:12:09 -0600
Subject: [PATCHv4 for soc 2/4] arm: socfpga: Add entries to enable make dtbs
 socfpga
In-Reply-To: <1360008731-17021-1-git-send-email-dinguyen@altera.com>
References: <1360008731-17021-1-git-send-email-dinguyen@altera.com>
Message-ID: <1360008731-17021-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Tested-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
---
 arch/arm/boot/dts/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5ebb44f..1b8276c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -124,6 +124,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
 	sh7372-mackerel.dtb
+dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
+	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
-- 
1.7.9.5

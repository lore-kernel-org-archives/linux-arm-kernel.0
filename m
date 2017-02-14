From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Feb 2017 18:01:51 +0100
Subject: [PATCH v6 11/14] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <5df183ed3b05e582df0bbe17c67ea097d8173dd3.1487091464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Add maintainer entry for Marvell Xenon eMMC/SD/SDIO
Host Controller drivers.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9e3d94..f4fea77165d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7757,6 +7757,13 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/mmc/host/mvsdio.*
 
+MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
+M:	Ziji Hu <huziji@marvell.com>
+L:	linux-mmc at vger.kernel.org
+S:	Supported
+F:	drivers/mmc/host/sdhci-xenon*
+F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev at vger.kernel.org
 S:	Orphan
-- 
git-series 0.9.1

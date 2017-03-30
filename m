From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 17:23:02 +0200
Subject: [PATCH v7 10/13] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Message-ID: <9dc4051aec96f86ed1655fcbbbd4140e012ef5cb.1490886907.git-series.gregory.clement@free-electrons.com>
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
index c45c02bc6082..553b508e9134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7862,6 +7862,13 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/mmc/host/mvsdio.*
 
+MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
+M:	Hu Ziji <huziji@marvell.com>
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

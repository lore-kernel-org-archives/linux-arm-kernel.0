From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Dec 2016 18:48:34 +0100
Subject: [PATCH v4 05/12] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Message-ID: <84c0e00dadec80ee5ab47e7472f4b88aba9ed6ef.1481651244.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
Controller drivers.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c44795306342..1a5c4c30ea24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7604,6 +7604,11 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/mmc/host/mvsdio.*
 
+MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
+M:	Ziji Hu <huziji@marvell.com>
+L:	linux-mmc at vger.kernel.org
+S:	Supported
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev at vger.kernel.org
 S:	Orphan
-- 
git-series 0.9.1

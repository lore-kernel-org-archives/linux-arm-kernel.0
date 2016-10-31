From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:53 +0100
Subject: [PATCH 4/10] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <04cb16b5ffe78d151e64c41b6ef8183b8ebb00e3.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ziji Hu <huziji@marvell.com>

Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
Controller drivers.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+), 0 deletions(-)

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
git-series 0.8.10

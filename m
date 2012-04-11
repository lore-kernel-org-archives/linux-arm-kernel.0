From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Apr 2012 13:54:44 +0200
Subject: [PATCH 3/5] MAINTAINERS: add entry for Atmel DMA driver
In-Reply-To: <cover.1334137680.git.nicolas.ferre@atmel.com>
References: <cover.1334137680.git.nicolas.ferre@atmel.com>
Message-ID: <a322a49e3fe11155f8b0dc19bedaf21018b390fb.1334137680.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ac46d8..4fc6a6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,6 +1331,14 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL DMA DRIVER
+M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/dma/at_hdmac.c
+F:	drivers/dma/at_hdmac_regs.h
+F:	arch/arm/mach-at91/include/mach/at_hdmac.h
+
 ATMEL ISI DRIVER
 M:	Josh Wu <josh.wu@atmel.com>
 L:	linux-media at vger.kernel.org
-- 
1.7.9.4

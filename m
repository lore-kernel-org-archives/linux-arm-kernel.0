From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 22 Oct 2014 17:22:20 +0200
Subject: [PATCH v7 3/3] MAINTAINERS: add entry for Atmel XDMA driver
In-Reply-To: <1413991340-11617-1-git-send-email-ludovic.desroches@atmel.com>
References: <1413991340-11617-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1413991340-11617-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc69ca4..74db724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1713,6 +1713,13 @@ F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
 F:	include/linux/platform_data/dma-atmel.h
 
+ATMEL XDMA DRIVER
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-arm-kernel at lists.infradead.org
+L:	dmaengine at vger.kernel.org
+S:	Supported
+F:	drivers/dma/at_xdmac.c
+
 ATMEL I2C DRIVER
 M:	Ludovic Desroches <ludovic.desroches@atmel.com>
 L:	linux-i2c at vger.kernel.org
-- 
2.0.3

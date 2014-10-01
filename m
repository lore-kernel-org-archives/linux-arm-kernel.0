From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 1 Oct 2014 16:59:25 +0200
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for Atmel XDMA driver
In-Reply-To: <1412175565-810-1-git-send-email-ludovic.desroches@atmel.com>
References: <1412175565-810-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1412175565-810-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65cc66d..5f0849d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1684,6 +1684,13 @@ F:	drivers/dma/at_hdmac.c
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

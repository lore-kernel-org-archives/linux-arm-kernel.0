From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:38 +0200
Subject: [PATCH 02/11] MAINTAINERS: update entry for Microchip NAND driver
 support
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <364c788f6a7cf2ab70ce57e8d24709eb4d9fd563.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the Microchip/Atmel NAND controller driver maintainer
by removing Josh and adding Tudor.

Cc: Josh Wu <rainyfeeling@outlook.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f97f1f83398..43fa2ebb292e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9528,7 +9528,7 @@ F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
 MICROCHIP / ATMEL NAND DRIVER
-M:	Josh Wu <rainyfeeling@outlook.com>
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd at lists.infradead.org
 S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
-- 
2.17.1

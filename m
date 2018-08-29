From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:39 +0200
Subject: [PATCH 03/11] MAINTAINERS: media: change Microchip ISI,
 ISC maintainers
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <f5c7302265c8d5df4398359f5056faedabfa0fb0.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ISC, Songjun is not with Microchip anymore, his address shouldn't be
reachable.
For ISI, Eugen can handle the maintenance now.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43fa2ebb292e..6eaf54960c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2494,7 +2494,7 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-at91.c
 
 ATMEL ISI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media at vger.kernel.org
 S:	Supported
 F:	drivers/media/platform/atmel/atmel-isi.c
@@ -9520,7 +9520,7 @@ S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
 MICROCHIP / ATMEL ISC DRIVER
-M:	Songjun Wu <songjun.wu@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media at vger.kernel.org
 S:	Supported
 F:	drivers/media/platform/atmel/atmel-isc.c
-- 
2.17.1

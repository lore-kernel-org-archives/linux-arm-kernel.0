From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 20 Oct 2017 15:31:19 +0200
Subject: [PATCH v3 3/5] MAINTAINERS: add Atmel PTC entries
In-Reply-To: <20171020133121.7992-1-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Message-ID: <20171020133121.7992-4-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries for the Atmel PTC Subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0630482e701b..e1bf4c9d7696 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,6 +2371,13 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 F:	include/linux/platform_data/atmel_mxt_ts.h
 
+ATMEL PTC SUBSYSTEM DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-input at vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/input/atmel,ptc.txt
+F:	drivers/input/misc/atmel_ptc.c
+
 ATMEL NAND DRIVER
 M:	Wenyou Yang <wenyou.yang@atmel.com>
 M:	Josh Wu <rainyfeeling@outlook.com>
-- 
2.12.2

From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 21 Apr 2017 10:39:22 +0200
Subject: [PATCH v2 3/5] MAINTAINERS: add Atmel PTC entries
In-Reply-To: <20170421083924.15096-1-ludovic.desroches@microchip.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Message-ID: <20170421083924.15096-4-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries for the Atmel PTC Subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 860dacb..e1b8b0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2323,6 +2323,13 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 F:	include/linux/platform_data/atmel_mxt_ts.h
 
+ATMEL PTC SUBSYSTEM DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-input at vger.kernel.org
+S:	Supported
+F:	drivers/input/misc/atmel_ptc.c
+F:	include/uapi/linux/atmel_ptc.h
+
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
 L:	linux-scsi at vger.kernel.org
-- 
2.9.0

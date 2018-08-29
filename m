From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:44 +0200
Subject: [PATCH 08/11] MAINTAINERS: iio: add co-maintainer to
 SAMA5D2-compatible ADC driver
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <377944526957bba407e7b1cd53201063493c7d8d.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Eugen as co-maintainer with Ludovic of Microchip SAMA5D2-compatible
ADC driver.
Also add the binding documentation/include as file pattern.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fca67dcb84e0..3f5494b33d89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2521,9 +2521,12 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
 ATMEL SAMA5D2 ADC DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio at vger.kernel.org
 S:	Supported
 F:	drivers/iio/adc/at91-sama5d2_adc.c
+F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
 ATMEL SDMMC DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-- 
2.17.1

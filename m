From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Mar 2017 17:21:01 +0200
Subject: [PATCH] MAINTAINERS: Add memory drivers to AT91 entry
Message-ID: <20170327152101.21977-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both atmel-ebi and atmel-sdram are maintained as part of the Atmel ARM
SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c45c02bc6082..6531d239db6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1111,6 +1111,7 @@ F:	arch/arm/boot/dts/at91*.dtsi
 F:	arch/arm/boot/dts/sama*.dts
 F:	arch/arm/boot/dts/sama*.dtsi
 F:	arch/arm/include/debug/at91.S
+F:	drivers/memory/atmel*
 
 ARM/ATMEL AT91 Clock Support
 M:	Boris Brezillon <boris.brezillon@free-electrons.com>
-- 
2.11.0

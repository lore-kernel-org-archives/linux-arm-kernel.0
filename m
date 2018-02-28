From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 28 Feb 2018 15:56:41 +0100
Subject: [PATCH 1/3] MAINTAINERS: ARM: at91: update entry for ARM/Microchip
Message-ID: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the entry name and move it to its alphabetical location.
We move to ARM/Microchip instead of ARM/ATMEL to reflect the merger
that is now nearly 2 years old.
AT91 is kept as the identity of our community. The atmel pattern is
obviously kept as well. I removed the names of the different SoCs as
they are better exposed in the arch/arm/mach-at91/Kconfig entries.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi,

This patch goes on top of linux-next because Alexandre's email change is taken
into account (already in arm-soc).

Best regards,
  Nicolas

 MAINTAINERS | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 866a5d0c0f64..88759f8a13ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,27 +1236,6 @@ M:	Boris Brezillon <boris.brezillon@free-electrons.com>
 S:	Maintained
 F:	drivers/clk/at91
 
-ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.linux4sam.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
-S:	Supported
-N:	at91
-N:	atmel
-F:	arch/arm/mach-at91/
-F:	include/soc/at91/
-F:	arch/arm/boot/dts/at91*.dts
-F:	arch/arm/boot/dts/at91*.dtsi
-F:	arch/arm/boot/dts/sama*.dts
-F:	arch/arm/boot/dts/sama*.dtsi
-F:	arch/arm/include/debug/at91.S
-F:	drivers/memory/atmel*
-F:	drivers/watchdog/sama5d4_wdt.c
-X:	drivers/input/touchscreen/atmel_mxt_ts.c
-X:	drivers/net/wireless/atmel/
-
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -1656,6 +1635,27 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 F:	arch/arm/mach-ks8695/
 S:	Odd Fixes
 
+ARM/Microchip (AT91) SoC support
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+W:	http://www.linux4sam.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
+S:	Supported
+N:	at91
+N:	atmel
+F:	arch/arm/mach-at91/
+F:	include/soc/at91/
+F:	arch/arm/boot/dts/at91*.dts
+F:	arch/arm/boot/dts/at91*.dtsi
+F:	arch/arm/boot/dts/sama*.dts
+F:	arch/arm/boot/dts/sama*.dtsi
+F:	arch/arm/include/debug/at91.S
+F:	drivers/memory/atmel*
+F:	drivers/watchdog/sama5d4_wdt.c
+X:	drivers/input/touchscreen/atmel_mxt_ts.c
+X:	drivers/net/wireless/atmel/
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.15.1

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 12 Aug 2017 23:53:45 +0200
Subject: [PATCH] MAINTAINERS: Add SoC drivers to AT91 entry
Message-ID: <20170812215345.10011-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We (the AT91/Atmel SoC maintainers) are not seeing patches for several
drivers present only on our SoCs. Add more patterns to match at91 and atmel
drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..6ba83a50a926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1158,6 +1158,8 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.linux4sam.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
 S:	Supported
+N:	at91
+N:	atmel
 F:	arch/arm/mach-at91/
 F:	include/soc/at91/
 F:	arch/arm/boot/dts/at91*.dts
@@ -1166,6 +1168,9 @@ F:	arch/arm/boot/dts/sama*.dts
 F:	arch/arm/boot/dts/sama*.dtsi
 F:	arch/arm/include/debug/at91.S
 F:	drivers/memory/atmel*
+F:	drivers/watchdog/sama5d4_wdt.c
+X:	drivers/input/touchscreen/atmel_mxt_ts.c
+X:	drivers/net/wireless/atmel/
 
 ARM/ATMEL AT91 Clock Support
 M:	Boris Brezillon <boris.brezillon@free-electrons.com>
-- 
2.14.0

From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri,  8 Feb 2013 18:18:03 +1300
Subject: [PATCH] arm: vt8500: Update MAINTAINERS entry for arch-vt8500
Message-ID: <1360300683-31779-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the VT8500 entries in alphabetical order and add missing entries
for the files.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 MAINTAINERS |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 212c255..2641425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1248,12 +1248,17 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
+F:	drivers/clocksource/vt8500_timer.c
+F:	drivers/gpio/gpio-vt8500.c
+F:	drivers/mmc/host/wmt-sdmmc.c
+F:	drivers/pwm/pwm-vt8500.c
+F:	drivers/rtc/rtc-vt8500.c
+F:	drivers/tty/serial/vt8500_serial.c
+F:	drivers/usb/host/ehci-vt8500.c
+F:	drivers/usb/host/uhci-platform.c
 F:	drivers/video/vt8500lcdfb.*
 F:	drivers/video/wm8505fb*
 F:	drivers/video/wmt_ge_rops.*
-F:	drivers/tty/serial/vt8500_serial.c
-F:	drivers/rtc/rtc-vt8500.c
-F:	drivers/mmc/host/wmt-sdmmc.c
 
 ARM/ZIPIT Z2 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
-- 
1.7.9.5

From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 19:43:21 +1300
Subject: [PATCH] MAINTAINERS: vt8500: Update maintained files for arch/vt8500
Message-ID: <1390459401-30549-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed maintainership of the ehci-platform.c and uhci-platform.c
drivers. These drivers are not solely used by arch-vt8500 anymore,
and are captured under Alan Stern's 'USB EHCI DRIVER' and
'USB UHCI DRIVER' wildcards.

Add maintainership for the VT8500's clock, irq and pinctrl drivers
which were added/migrated quite some time ago.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a6e4ac..ac26897 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1341,14 +1341,15 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
+F:	drivers/clk/clk-vt8500.c
 F:	drivers/clocksource/vt8500_timer.c
 F:	drivers/i2c/busses/i2c-wmt.c
+F:	drivers/irqchip/irq-vt8500.c
 F:	drivers/mmc/host/wmt-sdmmc.c
+F:	drivers/pinctrl/vt8500/
 F:	drivers/pwm/pwm-vt8500.c
 F:	drivers/rtc/rtc-vt8500.c
 F:	drivers/tty/serial/vt8500_serial.c
-F:	drivers/usb/host/ehci-platform.c
-F:	drivers/usb/host/uhci-platform.c
 F:	drivers/video/vt8500lcdfb.*
 F:	drivers/video/wm8505fb*
 F:	drivers/video/wmt_ge_rops.*
-- 
1.7.9.5

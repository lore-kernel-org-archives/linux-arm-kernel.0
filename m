From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Oct 2015 15:42:37 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
Message-ID: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since eafbaac ("MAINTAINERS: Add "R:" designated-reviewers tag") we
have been able to tag specific people as Reviewers.  These are key
individuals who are tasked with or volunteer to review code submitted
to a subsystem or specific file.  However, according to MAINTAINERS
we have 1046 Maintainers and only a mere 22 Reviewers.  I believe
these numbers to be incorrect, as many of these Maintainers are in
fact Reviewers.

I have taken the time to identify some of the Reviewers who pertain
to subsystems which I look after, and have changed their status from
Maintainer (collector of patches) to Reviewer (reviewer of code).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---

 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9de185d..07bc92f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -392,7 +392,7 @@ F:	drivers/media/i2c/adp1653.c
 F:	include/media/adp1653.h
 
 ADP5520 BACKLIGHT DRIVER WITH IO EXPANDER (ADP5520/ADP5501)
-M:	Michael Hennerich <michael.hennerich@analog.com>
+R:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://wiki.analog.com/ADP5520
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -411,7 +411,7 @@ F:	drivers/input/keyboard/adp5588-keys.c
 F:	drivers/gpio/gpio-adp5588.c
 
 ADP8860 BACKLIGHT DRIVER (ADP8860/ADP8861/ADP8863)
-M:	Michael Hennerich <michael.hennerich@analog.com>
+R:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://wiki.analog.com/ADP8860
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
@@ -2049,8 +2049,8 @@ S:	Maintained
 F:	drivers/net/wireless/b43legacy/
 
 BACKLIGHT CLASS/SUBSYSTEM
-M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Lee Jones <lee.jones@linaro.org>
+R:	Jingoo Han <jingoohan1@gmail.com>
 S:	Maintained
 F:	drivers/video/backlight/
 F:	include/linux/backlight.h
@@ -3364,7 +3364,7 @@ F:	include/linux/dm-*.h
 F:	include/uapi/linux/dm-*.h
 
 DIALOG SEMICONDUCTOR DRIVERS
-M:	Support Opensource <support.opensource@diasemi.com>
+R:	Support Opensource <support.opensource@diasemi.com>
 W:	http://www.dialog-semiconductor.com/products
 S:	Supported
 F:	Documentation/hwmon/da90??
@@ -5212,7 +5212,7 @@ S:	Orphan
 F:	drivers/scsi/ips.*
 
 ICH LPC AND GPIO DRIVER
-M:	Peter Tyser <ptyser@xes-inc.com>
+R:	Peter Tyser <ptyser@xes-inc.com>
 S:	Maintained
 F:	drivers/mfd/lpc_ich.c
 F:	drivers/gpio/gpio-ich.c
@@ -6855,7 +6855,7 @@ F:	include/linux/mcb.h
 F:	Documentation/men-chameleon-bus.txt
 
 MEN F21BMC (Board Management Controller)
-M:	Andreas Werner <andreas.werner@men.de>
+R:	Andreas Werner <andreas.werner@men.de>
 S:	Supported
 F:	drivers/mfd/menf21bmc.c
 F:	drivers/watchdog/menf21bmc_wdt.c
@@ -9009,8 +9009,8 @@ S:	Maintained
 F:	drivers/video/fbdev/s3c-fb.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
-M:	Sangbeom Kim <sbkim73@samsung.com>
-M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+R:	Sangbeom Kim <sbkim73@samsung.com>
+R:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
 L:	linux-kernel at vger.kernel.org
 L:	linux-samsung-soc at vger.kernel.org
 S:	Supported
@@ -10434,20 +10434,20 @@ F:	sound/soc/codecs/lm49453*
 F:	sound/soc/codecs/isabelle*
 
 TI LP855x BACKLIGHT DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+R:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
 F:	Documentation/backlight/lp855x-driver.txt
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
 TI LP8727 CHARGER DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+R:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
 F:	drivers/power/lp8727_charger.c
 F:	include/linux/platform_data/lp8727.h
 
 TI LP8788 MFD DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+R:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
 F:	drivers/iio/adc/lp8788_adc.c
 F:	drivers/leds/leds-lp8788.c
-- 
1.9.1

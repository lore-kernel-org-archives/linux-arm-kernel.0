From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sat, 29 Oct 2016 08:10:02 -0200
Subject: [PATCH 1/2] ABI: rtc-ab8500: fix rtc_calibration documentation
Message-ID: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "What:" field at the ABI should describe the location of
the ABI, e. g. the position under a mounted sysfs.

Fix it.

Cc: Mark Godfrey <mark.godfrey@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: rtc-linux at googlegroups.com
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 .../ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration b/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
index 4cf1e72222d9..ec950c93e5c6 100644
--- a/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
+++ b/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
@@ -1,8 +1,9 @@
-What:           Attribute for calibrating ST-Ericsson AB8500 Real Time Clock
+What:           /sys/class/rtc/rtc0/device/rtc_calibration
 Date:           Oct 2011
 KernelVersion:  3.0
 Contact:        Mark Godfrey <mark.godfrey@stericsson.com>
-Description:    The rtc_calibration attribute allows the userspace to
+Description:    Attribute for calibrating ST-Ericsson AB8500 Real Time Clock
+		The rtc_calibration attribute allows the userspace to
                 calibrate the AB8500.s 32KHz Real Time Clock.
                 Every 60 seconds the AB8500 will correct the RTC's value
                 by adding to it the value of this attribute.
-- 
2.7.4

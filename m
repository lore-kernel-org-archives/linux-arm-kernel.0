From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 14 Oct 2011 21:14:03 +0100
Subject: [PATCH] MANITAINERS: Add Cragganmore reference platform to Wolfson
	support
Message-ID: <1318623243-20894-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a85a9b7..f1b438a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7325,6 +7325,7 @@ T:	git git://opensource.wolfsonmicro.com/linux-2.6-audioplus
 W:	http://opensource.wolfsonmicro.com/content/linux-drivers-wolfson-devices
 S:	Supported
 F:	Documentation/hwmon/wm83??
+F:	arch/arm/mach-s3c64xx/mach-crag6410*
 F:	drivers/leds/leds-wm83*.c
 F:	drivers/input/misc/wm831x-on.c
 F:	drivers/input/touchscreen/wm831x-ts.c
-- 
1.7.6.3

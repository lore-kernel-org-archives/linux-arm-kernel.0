From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  5 Aug 2015 15:28:12 +0100
Subject: [PATCH 4/4] MAINTAINERS: Add Liviu Dudau as maintainer for ARM HDLCD
 driver.
In-Reply-To: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1438784892-27888-5-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MAINTAINERS file for HDLCD driver.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Joe Perches <joe@perches.com>
Cc: Jiri Slaby <jslaby@suse.com>

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 443dc62..084818e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -790,6 +790,12 @@ S:	Maintained
 F:	drivers/video/fbdev/arcfb.c
 F:	drivers/video/fbdev/core/fb_defio.c
 
+ARM HDLCD DRM DRIVER
+M:	Liviu Dudau <liviu.dudau@arm.com>
+S:	Maintained
+F:	drivers/gpu/drm/arm/
+F:	Documentation/devicetree/bindings/arm/arm,hdlcd.txt
+
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
-- 
2.4.6

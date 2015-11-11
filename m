From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 11 Nov 2015 16:06:50 +0000
Subject: [PATCH v2 4/4] MAINTAINERS: Add Liviu Dudau as maintainer for ARM
 HDLCD driver.
In-Reply-To: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
References: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1447258010-2234-5-git-send-email-Liviu.Dudau@arm.com>
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
index fca7daf..d74af10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -820,6 +820,12 @@ S:	Maintained
 F:	drivers/net/arcnet/
 F:	include/uapi/linux/if_arcnet.h
 
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
2.6.0

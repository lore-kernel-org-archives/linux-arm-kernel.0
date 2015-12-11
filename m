From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 11 Dec 2015 15:04:47 +0000
Subject: [PATCH v6 4/4] MAINTAINERS: Add Liviu Dudau as maintainer for ARM
 HDLCD driver.
In-Reply-To: <1449846287-21398-1-git-send-email-Liviu.Dudau@arm.com>
References: <1449846287-21398-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1449846287-21398-5-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MAINTAINERS file for HDLCD driver.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: David S. Miller <davem@davemloft.net>

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b..4208dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -820,6 +820,12 @@ S:	Maintained
 F:	drivers/net/arcnet/
 F:	include/uapi/linux/if_arcnet.h
 
+ARM HDLCD DRM DRIVER
+M:	Liviu Dudau <liviu.dudau@arm.com>
+S:	Supported
+F:	drivers/gpu/drm/arm/
+F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
+
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
-- 
2.6.4

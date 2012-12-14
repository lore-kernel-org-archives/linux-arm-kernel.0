From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 11:44:52 -0800
Subject: [PATCH 2/2] MAINTAINERS: Add an entry for omap related .dts files
In-Reply-To: <20121214194325.9874.95898.stgit@muffinssi.local>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
Message-ID: <20121214194452.9874.40037.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All your omap .dts files are belong to us.

Beno?t has been doing a good job picking up most of the
omap .dts files so far. Let's make sure we both get
cc:ed for the related patches.

The .dts patches need to be queued by us as separate
patches from drivers and other code changes to avoid
pointless merge conflists like we saw with v3.8
networking changes.

Cc: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc485c..4927e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5253,6 +5253,15 @@ F:	arch/arm/*omap*/
 F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/i2c-omap.h
 
+OMAP DEVICE TREE SUPPORT
+M:	Beno?t Cousson <b-cousson@ti.com>
+M:	Tony Lindgren <tony@atomide.com>
+L:	linux-omap at vger.kernel.org
+L:	devicetree-discuss at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/*omap*
+F:	arch/arm/boot/dts/*am3*
+
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap at vger.kernel.org

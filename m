From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed, 11 Oct 2017 15:29:36 +0800
Subject: [PATCH v12 3/5] MAINTAINERS: add entry for Rockchip RGA driver
In-Reply-To: <20171011072938.383-1-jacob-chen@iotwrt.com>
References: <20171011072938.383-1-jacob-chen@iotwrt.com>
Message-ID: <20171011072938.383-4-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f375f7fc..335497bbc3f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11509,6 +11509,13 @@ F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 
+ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
+M:	Jacob chen <jacob-chen@iotwrt.com>
+L:	linux-media at vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/rockchip/rga/
+F:	Documentation/devicetree/bindings/media/rockchip-rga.txt
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev at vger.kernel.org
-- 
2.14.1

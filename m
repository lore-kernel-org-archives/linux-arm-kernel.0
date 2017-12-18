From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Mon, 18 Dec 2017 20:14:45 +0800
Subject: [PATCH v4 16/16] MAINTAINERS: add entry for Rockchip ISP1 driver
In-Reply-To: <20171218121445.6086-1-jacob-chen@iotwrt.com>
References: <20171218121445.6086-1-jacob-chen@iotwrt.com>
Message-ID: <20171218121445.6086-13-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacob Chen <jacob2.chen@rock-chips.com>

Add MAINTAINERS entry for the rockchip isp1 driver.
This driver is maintained by rockchip officially and it
will be used for rockchip SoC on all linux-kernel based OS.

Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b05bc2c5e85c..614196ed7265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11665,6 +11665,16 @@ F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 
+ROCKCHIP ISP V1 DRIVER
+M:	Jacob chen <jacob2.chen@rock-chips.com>
+M:	Shunqian Zheng <zhengsq@rock-chips.com>
+M:	Yichong Zhong <zyc@rock-chips.com>
+L:	linux-media at vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/rockchip/isp1/
+F:	Documentation/devicetree/bindings/media/rockchip-isp1.txt
+F:	Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
+
 ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
 M:	Jacob chen <jacob2.chen@rock-chips.com>
 L:	linux-media at vger.kernel.org
-- 
2.15.1

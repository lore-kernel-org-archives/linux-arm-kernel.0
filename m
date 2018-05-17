From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 17 May 2018 22:19:23 +0300
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
Message-ID: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds rave-sp powerbutton and backlight devices to RDU1 device tree.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac04ad08..98cc107098e0 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -581,6 +581,14 @@
 		watchdog {
 			compatible = "zii,rave-sp-watchdog";
 		};
+
+		backlight {
+			compatible = "zii,rave-sp-backlight";
+		};
+
+		pwrbutton {
+			compatible = "zii,rave-sp-pwrbutton";
+		};
 	};
 };
 
-- 
2.11.0

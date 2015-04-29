From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Apr 2015 09:59:02 +0200
Subject: [PATCH 3/4] ARM: dts: sunxi: A10s Olinuxino Micro: add spi2.
In-Reply-To: <cover.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
Message-ID: <8b0c262adb5fb987a33c0fee7f2d52c6e2105554.1430295711.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi2 is exposed on the UEXT connector.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index aa88ee8..cd8d08a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -182,6 +182,12 @@
 	status = "okay";
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.1.4

From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:48 -0000
Subject: [PATCH 8/9] ARM: dts: sunxi: A10s Olinuxino Micro: add spi2.
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <c479a62f6d28bbda65c23fc00a0a8499cf639b76.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi2 is exposed on the UEXT connector.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index a7e19e4..b546fc2 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -185,6 +185,13 @@
 	status = "okay";
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>,
+		    <&spi2_cs0_pins_a>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.1.4

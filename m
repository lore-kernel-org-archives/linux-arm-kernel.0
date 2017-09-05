From: heiko@sntech.de (Heiko Stuebner)
Date: Tue,  5 Sep 2017 12:57:39 +0200
Subject: [PATCH 7/7] ARM: dts: rockchip: enable gpu on rk3188-radxarock
In-Reply-To: <20170905105739.8330-1-heiko@sntech.de>
References: <20170905105739.8330-1-heiko@sntech.de>
Message-ID: <20170905105739.8330-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the gpu node on that board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 53d6fc2fdbce..00e05a6662ac 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -176,6 +176,10 @@
 	cpu0-supply = <&vdd_arm>;
 };
 
+&gpu {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.14.1

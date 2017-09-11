From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 13:56:21 +0530
Subject: [PATCH 1/2] ARM: dts: rockchip: rk3288-vyasa: Enable vops and hdmi
 output
Message-ID: <1505118382-6023-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 9d473fe..f70a52f 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -82,6 +82,10 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -293,6 +297,22 @@
 	status = "okay";
 };
 
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.7.4

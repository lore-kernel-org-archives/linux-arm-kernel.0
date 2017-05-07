From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:46:33 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: enable eDP panel at Firefly Release
In-Reply-To: <20170507144633.11714-1-ayaka@soulik.info>
References: <20170507144633.11714-1-ayaka@soulik.info>
Message-ID: <20170507144633.11714-3-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dts b/arch/arm/boot/dts/rk3288-firefly.dts
index 14271be..b3964c8 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dts
+++ b/arch/arm/boot/dts/rk3288-firefly.dts
@@ -48,10 +48,22 @@
 	compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
 };
 
+&edp {
+	status = "okay";
+};
+
+&edp_phy {
+	status = "okay";
+};
+
 &ir {
 	gpios = <&gpio7 RK_PA0 GPIO_ACTIVE_LOW>;
 };
 
+&panel {
+	status = "okay";
+};
+
 &pinctrl {
 	act8846 {
 		pmic_vsel: pmic-vsel {
@@ -69,3 +81,19 @@
 &pwm1 {
 	status = "okay";
 };
+
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
-- 
2.9.3

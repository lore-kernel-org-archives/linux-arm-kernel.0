From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 14 Nov 2014 16:32:25 +0100
Subject: [PATCH] ARM: dts: rockchip: enable PWM on Radxa Rock
Message-ID: <1415979145-19471-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables user space access to the 3 PWM available on the Radxa Rock headers.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 0950a05..6eb62c0 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -243,6 +243,18 @@
 	disable-wp;
 };
 
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
 &pinctrl {
 	pcfg_output_low: pcfg-output-low {
 		output-low;
-- 
2.1.0

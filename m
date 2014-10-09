From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 09 Oct 2014 18:38:44 +0200
Subject: [PATCH 08/21] thermal: dts: exynos: Adding LD010 regulator node
 necessary for TMU on Odroid U3 board
In-Reply-To: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1412872737-624-9-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index adadaf9..5364f1a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -209,6 +209,13 @@
 					regulator-always-on;
 				};
 
+				ldo10_reg: LDO10 {
+					regulator-name = "VDD18_MIPIHSI_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
 				ldo11_reg: LDO11 {
 					regulator-name = "VDD18_ABB1_1.8V";
 					regulator-min-microvolt = <1800000>;
-- 
2.0.0.rc2

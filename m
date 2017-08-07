From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Aug 2017 12:52:36 +0530
Subject: [PATCH 04/10] ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: get rid
 of tegra legacy gen1_i2c comment
In-Reply-To: <cover.1502087184.git.maitysanchayan@gmail.com>
References: <cover.1502087184.git.maitysanchayan@gmail.com>
Message-ID: <20708f65ed07e1368035f857923122a633ed0eb6.1502087184.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index a5c5bf82e45e..a91043d5ac20 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -169,7 +169,7 @@
 	status = "okay";
 };
 
-/* GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
+/* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 117dee65f3f7..bad86a0ebd82 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -210,10 +210,7 @@
 	};
 };
 
-/*
- * GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier
- * board)
- */
+/* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.13.3

From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 23 Jul 2014 04:23:00 +0200
Subject: [PATCH] ARM: tegra: apalis t30: fix device tree compatible node
Message-ID: <aa2cbaac07707c3d64599d3841b9d6f77567a91f.1406081870.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Working on sound support I noticed the Apalis T30 Evaluation board
device tree missing the more generic Apalis T30 compatible string.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---
 arch/arm/boot/dts/tegra30-apalis-eval.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 9921433..45d40f0 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "Toradex Apalis T30 on Apalis Evaluation Board";
-	compatible = "toradex,apalis_t30-eval", "nvidia,tegra30";
+	compatible = "toradex,apalis_t30-eval", "toradex,apalis_t30", "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c at 7000c000/rtc at 68";
-- 
1.7.9.5

From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Tue, 26 Jan 2016 17:59:17 +0100
Subject: [PATCH v2 1/2] ARM: tegra: Fixed typo
In-Reply-To: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
Message-ID: <1453827558-10954-2-git-send-email-ralf@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 +-
 arch/arm/boot/dts/tegra124.dtsi | 2 +-
 arch/arm/boot/dts/tegra20.dtsi  | 2 +-
 arch/arm/boot/dts/tegra30.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index d845bd1..5017ed8 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -256,7 +256,7 @@
 	 * driver and APB DMA based serial driver for higher baudrate
 	 * and performace. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra114-uart", "nvidia,tegra20-uart" and to enable
-	 * the APB DMA based serial driver, the comptible is
+	 * the APB DMA based serial driver, the compatible is
 	 * "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart".
 	 */
 	uarta: serial at 70006000 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 68669f7..995289b 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -322,7 +322,7 @@
 	 * driver and APB DMA based serial driver for higher baudrate
 	 * and performace. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra124-uart", "nvidia,tegra20-uart" and to enable
-	 * the APB DMA based serial driver, the comptible is
+	 * the APB DMA based serial driver, the compatible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
 	 */
 	uarta: serial at 0,70006000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 33173e1..8fb61b9 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -309,7 +309,7 @@
 	 * driver and APB DMA based serial driver for higher baudrate
 	 * and performace. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra20-uart" and to enable the APB DMA based serial
-	 * driver, the comptible is "nvidia,tegra20-hsuart".
+	 * driver, the compatible is "nvidia,tegra20-hsuart".
 	 */
 	uarta: serial at 70006000 {
 		compatible = "nvidia,tegra20-uart";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 313e260..c6edc8c 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -371,7 +371,7 @@
 	 * driver and APB DMA based serial driver for higher baudrate
 	 * and performace. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
-	 * the APB DMA based serial driver, the comptible is
+	 * the APB DMA based serial driver, the compatible is
 	 * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
 	 */
 	uarta: serial at 70006000 {
-- 
2.4.10

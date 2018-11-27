From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:16 +0100
Subject: [PATCH 15/77] ARM: dts: sunxi: Remove the CMA node label
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <a41427fb5ace4ad3fb2978ef2e4dd85c872a883c.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no phandle pointing to the CMA pool, so it's label is unnecessary.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi     | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 307c6790b227..b6b67d84ddda 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -114,7 +114,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: default-pool {
+		default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f7dcf8d21fd2..1ca1fdff2288 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -181,7 +181,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: default-pool {
+		default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index a8b2c4d14f99..1c4f7e1930d8 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -196,7 +196,7 @@
 		ranges;
 
 		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
-		cma_pool: default-pool {
+		default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index b3921c5171ed..22883f1b80e2 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -124,7 +124,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		cma_pool: default-pool {
+		default-pool {
 			compatible = "shared-dma-pool";
 			size = <0x6000000>;
 			alloc-ranges = <0x4a000000 0x6000000>;
-- 
git-series 0.9.1

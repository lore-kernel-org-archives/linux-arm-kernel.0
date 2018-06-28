From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 15:14:13 +0300
Subject: [PATCH] ARM: dts: armada388-clearfog: update spi flash comment
Message-ID: <54d6bdd0a348926cabb4083cf2e98e8124de95f7.1530188053.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the comment stating that the spi is not populated. The spi flash
is populated on production SOMs.

This is a follow up to commit 12b427331ae5 (ARM: dts:
armada388-clearfog: enable spi flash).

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/armada-388-clearfog.dts  | 2 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 32b1e09b8293..89a354b43978 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -230,7 +230,7 @@
 &spi1 {
 	/*
 	 * Add SPI CS pins for clearfog:
-	 * CS0: W25Q32 (not populated on uSOM)
+	 * CS0: W25Q32
 	 * CS1:
 	 * CS2: mikrobus
 	 */
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 1da40bdfcef1..7c6ad2afb094 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -225,7 +225,7 @@
 &spi1 {
 	/*
 	 * Add SPI CS pins for clearfog:
-	 * CS0: W25Q32 (not populated on uSOM)
+	 * CS0: W25Q32
 	 * CS1: PIC microcontroller (Pro models)
 	 * CS2: mikrobus
 	 */
-- 
2.18.0

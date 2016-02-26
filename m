From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:18:36 +0900
Subject: [PATCH 9/9] ARM: dts: uniphier: add @{address} to EEPROM node
In-Reply-To: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456471116-8140-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456471116-8140-10-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just for consistent coding style.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
index 3d29d28..f7df088 100644
--- a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
+++ b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
@@ -43,7 +43,7 @@
  */
 
 &i2c0 {
-	eeprom {
+	eeprom at 50 {
 		compatible = "microchip,24lc128";
 		reg = <0x50>;
 	};
-- 
1.9.1

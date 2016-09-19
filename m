From: marex@denx.de (Marek Vasut)
Date: Mon, 19 Sep 2016 23:40:44 +0200
Subject: [PATCH 4/4] ARM: at91/dt: sama5d4: Add new MA5D4EVK manufacturer
 compat
In-Reply-To: <20160919214044.9615-1-marex@denx.de>
References: <20160919214044.9615-1-marex@denx.de>
Message-ID: <20160919214044.9615-4-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is now manufactured by Aries Embedded GmbH, update compat string.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi   | 4 ++--
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index 7c75872..b40dd9f 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -12,8 +12,8 @@
 #include "sama5d4.dtsi"
 
 / {
-	model = "DENX MA5D4";
-	compatible = "denx,ma5d4", "atmel,sama5d4", "atmel,sama5";
+	model = "Aries/DENX MA5D4";
+	compatible = "aries,ma5d4", "denx,ma5d4", "atmel,sama5d4", "atmel,sama5";
 
 	memory {
 		reg = <0x20000000 0x10000000>;
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
index a52f520..d4ebd90 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
@@ -13,8 +13,8 @@
 #include "at91-sama5d4_ma5d4.dtsi"
 
 / {
-	model = "DENX MA5D4EVK";
-	compatible = "denx,ma5d4evk", "atmel,sama5d4", "atmel,sama5";
+	model = "Aries/DENX MA5D4EVK";
+	compatible = "aries,ma5d4evk", "denx,ma5d4evk", "atmel,sama5d4", "atmel,sama5";
 
 	chosen {
 		stdout-path = "serial3:115200n8";
-- 
2.9.3

From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Mon,  1 Oct 2012 22:46:09 +0200
Subject: [PATCH] arm/dts: at91sam9g20ek_common: Fix typos in buttons labels.
Message-ID: <1349124369-28742-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..e6391a4 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -126,14 +126,14 @@
 		#size-cells = <0>;
 
 		btn3 {
-			label = "Buttin 3";
+			label = "Button 3";
 			gpios = <&pioA 30 1>;
 			linux,code = <0x103>;
 			gpio-key,wakeup;
 		};
 
 		btn4 {
-			label = "Buttin 4";
+			label = "Button 4";
 			gpios = <&pioA 31 1>;
 			linux,code = <0x104>;
 			gpio-key,wakeup;
-- 
1.7.9.5

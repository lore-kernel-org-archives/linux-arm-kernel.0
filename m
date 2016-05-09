From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 May 2016 14:51:19 +0800
Subject: [PATCH 2/2] ARM: at91/dt: use "atmel,sama5d3-nfc" compatible for nfc
In-Reply-To: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
References: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1462776680-5284-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the compatible "atmel,sama5d4-nfc" removal, use
"atmel,sama5d3-nfc" for the sama5d2's nfc node.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 78996bd..9817090 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -280,7 +280,7 @@
 			status = "disabled";
 
 			nfc at c0000000 {
-				compatible = "atmel,sama5d4-nfc";
+				compatible = "atmel,sama5d3-nfc";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = < /* NFC Command Registers */
-- 
2.7.4

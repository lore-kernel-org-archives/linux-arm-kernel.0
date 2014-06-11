From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 11 Jun 2014 18:14:41 +0800
Subject: [PATCH v2 3/4] dts: atmel: at91sam9rl: switch ssc compatible string
In-Reply-To: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402481682-9811-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the SSC integrate in at91sam9rl support frame sync length
extension, so switch compatible string to support this feature.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - New

 arch/arm/boot/dts/at91sam9rl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 1da1831..fa32de9 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -203,7 +203,7 @@
 			};
 
 			ssc0: ssc at fffc0000 {
-				compatible = "atmel,at91rm9200-ssc";
+				compatible = "atmel,at91sam9rl-ssc";
 				reg = <0xfffc0000 0x4000>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
@@ -212,7 +212,7 @@
 			};
 
 			ssc1: ssc at fffc4000 {
-				compatible = "atmel,at91rm9200-ssc";
+				compatible = "atmel,at91sam9rl-ssc";
 				reg = <0xfffc4000 0x4000>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
-- 
1.8.5.2

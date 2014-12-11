From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 11 Dec 2014 11:14:40 +0800
Subject: [PATCH 2/3] ARM: at91: sama5d3xek/dt: use dt ids for wm8904
In-Reply-To: <1418267681-4091-1-git-send-email-voice.shen@atmel.com>
References: <1418267681-4091-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1418267681-4091-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Morozov <linux@meltdown.ru>

Using the wm8904 device tree compatible string.

Signed-off-by: Alexander Morozov <linux@meltdown.ru>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 49c10d3..2a1aa58 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -45,7 +45,7 @@
 			 */
 			i2c0: i2c at f0014000 {
 				wm8904: wm8904 at 1a {
-					compatible = "wm8904";
+					compatible = "wlf,wm8904";
 					reg = <0x1a>;
 					clocks = <&pck0>;
 					clock-names = "mclk";
-- 
2.1.0.24.g4109c28

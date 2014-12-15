From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Dec 2014 11:31:13 +0800
Subject: [PATCH v2 3/3] ARM: at91: at91sam9n12ek/dt: use dt ids for wm8904
In-Reply-To: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1418614273-2303-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the device tree ids for wm8904 codec.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v2: None

 arch/arm/boot/dts/at91sam9n12ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 13bb24e..9575c0d 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -54,7 +54,7 @@
 				status = "okay";
 
 				wm8904: codec at 1a {
-					compatible = "wm8904";
+					compatible = "wlf,wm8904";
 					reg = <0x1a>;
 					clocks = <&pck0>;
 					clock-names = "mclk";
-- 
2.1.0.24.g4109c28

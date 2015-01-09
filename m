From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 9 Jan 2015 17:18:16 +0800
Subject: [PATCH] ARM: at91: sama5d3: dt: correct the sound route
Message-ID: <1420795096-8944-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MICBIAS is a supply, should route to MIC while not IN1L.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 0399be6..83d0598 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -176,7 +176,7 @@
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"MICBIAS", "IN1L",
+			"Mic", "MICBIAS",
 			"IN1L", "Mic";
 
 		atmel,ssc-controller = <&ssc0>;
-- 
2.1.0.24.g4109c28

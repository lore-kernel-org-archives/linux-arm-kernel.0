From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:36 +0800
Subject: [PATCH 3/8] ARM: at91: sama5d3: correct the sound compatible string
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1395049541-28128-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the sama5d3 dtsi file in go into mainline before sound driver,
and, the sound compatible string is changed when go into mainline.
Add this patch to correct the sound compatible string.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 2938605..e1bd5767 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -156,7 +156,7 @@
 	};
 
 	sound {
-		compatible = "atmel,sama5d3ek-wm8904";
+		compatible = "atmel,asoc-wm8904";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pck0_as_audio_mck>;
 
-- 
1.8.5.2

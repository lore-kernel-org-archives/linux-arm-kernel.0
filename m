From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:41 +0800
Subject: [PATCH 8/8] ARM: at91/dt: add clock properties to the wm8904 codec
 node
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1395049541-28128-9-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <b.brezillon@overkiz.com>

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 306eef0..d9bb413 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -163,6 +163,8 @@
 		compatible = "atmel,asoc-wm8904";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pck0_as_audio_mck>;
+		clocks = <&pck0>;
+		clock-names = "pck0";
 
 		atmel,model = "wm8904 @ SAMA5D3EK";
 		atmel,audio-routing =
-- 
1.8.5.2

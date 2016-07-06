From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:45 +0800
Subject: [PATCH 4/9] ARM: dts: sun7i: lamobo-r1: Enable audio codec
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lamobo R1 has a headphone jack for audio output, and an onboard
microphone. These are tied to the SoC's internal audio codec.

Enable the audio codec.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index c5126a9c35fc..73c05dab0a69 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -95,6 +95,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.8.1

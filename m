From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:10 +0900
Subject: [PATCH 10/16] ARM: shmobile: bockw dts: set extal clock frequency
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <a5dc23f6896005a18629b5c1be0e39a9f6090bf5.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Sets the extal clock to the frequency of the oscillator installed by
default (33 MHz).

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 274a1b6f..0011975 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -61,6 +61,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <33333333>;
+};
+
 &mmcif {
 	pinctrl-0 = <&mmc_pins>;
 	pinctrl-names = "default";
-- 
2.1.4

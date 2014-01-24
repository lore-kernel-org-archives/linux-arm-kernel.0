From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 24 Jan 2014 10:19:03 +0200
Subject: [PATCH 5/9] ARM: DTS: omap4-sdp: No need to disable mcbsp3 node
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1390551547-12406-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All audio nodes has been set to disabled state in omap4.dtsi file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 513b01774966..9bbbbec1d63d 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -548,10 +548,6 @@
 	status = "okay";
 };
 
-&mcbsp3 {
-	status = "disabled";
-};
-
 &dmic {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dmic_pins>;
-- 
1.8.5.3

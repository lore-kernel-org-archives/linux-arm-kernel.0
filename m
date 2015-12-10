From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Dec 2015 21:36:31 +0800
Subject: [PATCH 3/3] ARM: dts: sun9i: cubieboard4: Enable Reduced Serial Bus
 controller
In-Reply-To: <1449754591-3999-1-git-send-email-wens@csie.org>
References: <1449754591-3999-1-git-send-email-wens@csie.org>
Message-ID: <1449754591-3999-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Reduced Serial Bus (RSB) controller is used to talk to the 3
companion ICs (2 PMICs, 1 RTC/codec IC) on the board.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 8c26b556e82a..382bd9fc5647 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -118,6 +118,10 @@
 	status = "okay";
 };
 
+&r_rsb {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.6.2

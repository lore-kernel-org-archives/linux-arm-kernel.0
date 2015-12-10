From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Dec 2015 21:36:30 +0800
Subject: [PATCH 2/3] ARM: dts: sun9i: cubieboard4: Enable consumer IR receiver
In-Reply-To: <1449754591-3999-1-git-send-email-wens@csie.org>
References: <1449754591-3999-1-git-send-email-wens@csie.org>
Message-ID: <1449754591-3999-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubieboard4 has a consumer IR receiver. Enable it in the DT.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 8791d49bed2d..8c26b556e82a 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -114,6 +114,10 @@
 	status = "okay";
 };
 
+&r_ir {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.6.2

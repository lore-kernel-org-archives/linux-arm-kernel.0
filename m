From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  2 Mar 2015 16:24:46 +0800
Subject: [PATCH v2 4/4] ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial
 Bus controller
In-Reply-To: <1425284686-5116-1-git-send-email-wens@csie.org>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
Message-ID: <1425284686-5116-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Reduced Serial Bus controller is used to talk to the onboard PMIC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 4cb25f8267c8..31882e6e7a38 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -125,6 +125,10 @@
 	};
 };
 
+&r_rsb {
+	status = "okay";
+};
+
 &r_uart {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_uart_pins_a>;
-- 
2.1.4

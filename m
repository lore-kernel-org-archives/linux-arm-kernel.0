From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Feb 2015 18:29:04 +0800
Subject: [PATCH 4/4] ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial Bus
 controller
In-Reply-To: <1424773744-15106-1-git-send-email-wens@csie.org>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
Message-ID: <1424773744-15106-5-git-send-email-wens@csie.org>
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

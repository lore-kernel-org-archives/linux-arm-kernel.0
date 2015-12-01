From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Dec 2015 13:47:25 +0800
Subject: [PATCH 7/7] ARM: dts: sun9i: optimus: Enable Reduced Serial Bus
 controller
In-Reply-To: <1448948845-28347-1-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
Message-ID: <1448948845-28347-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 79766e5867cd..c0060e4f7379 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -196,6 +196,10 @@
 	};
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

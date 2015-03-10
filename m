From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:13 +0800
Subject: [PATCH v5 02/12] ARM: dts: sun6i: hummingbird: Enable P2WI controller
In-Reply-To: <1425988764-23618-1-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
Message-ID: <1425988764-23618-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has an AXP221 PMIC hooked up to the P2WI controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 65ddaf4c72d2..533bedc5dd95 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -140,6 +140,10 @@
 	};
 };
 
+&p2wi {
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
 	status = "okay";
-- 
2.1.4

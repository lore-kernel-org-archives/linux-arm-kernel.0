From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 10 Nov 2014 19:55:08 +0100
Subject: [PATCH v2 3/5] ARM: sun7i: dtsi: add support for usbphy0
In-Reply-To: <cover.1415645258.git.rbyshko@gmail.com>
References: <cover.1415645258.git.rbyshko@gmail.com>
Message-ID: <ef8f31d5cf50014417bd08a326241ba01ec4cf03.1415645258.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82097c9..f787ccb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -552,8 +552,8 @@
 			reg-names = "phy_ctrl", "pmu1", "pmu2";
 			clocks = <&usb_clk 8>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 1>, <&usb_clk 2>;
-			reset-names = "usb1_reset", "usb2_reset";
+			resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
+			reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
 			status = "disabled";
 		};
 
-- 
2.1.2

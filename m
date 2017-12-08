From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri,  8 Dec 2017 22:54:16 +0100
Subject: [PATCH 2/5] arm: dts: sun8i: a83t: Add I2C0 pins group
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Message-ID: <20171208215419.30396-3-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pins group to configure it as I2C0.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 848cf3f19962..3bce6bd3dc79 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -347,6 +347,11 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			i2c0_pins: i2c0-pins {
+				pins = "PH0", "PH1";
+				function = "i2c0";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.11.0

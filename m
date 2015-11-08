From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  8 Nov 2015 17:04:39 +0100
Subject: [PATCH v2 6/8] ARM: dts: rockchip: add clock-cells for usb phy nodes
In-Reply-To: <1446998681-26436-1-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
Message-ID: <1446998681-26436-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the #clock-cells properties for the usbphy nodes as they
provide the pll-clocks now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 ++
 arch/arm/boot/dts/rk3188.dtsi  | 2 ++
 arch/arm/boot/dts/rk3288.dtsi  | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 946f187..3e4b41b 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -181,6 +181,7 @@
 			reg = <0x17c>;
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy1: usb-phy1 {
@@ -188,6 +189,7 @@
 			reg = <0x188>;
 			clocks = <&cru SCLK_OTGPHY1>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 6399942..48a287e 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -156,6 +156,7 @@
 			reg = <0x10c>;
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy1: usb-phy1 {
@@ -163,6 +164,7 @@
 			reg = <0x11c>;
 			clocks = <&cru SCLK_OTGPHY1>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e978fb2..f778458 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -960,6 +960,7 @@
 			reg = <0x320>;
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy1: usb-phy1 {
@@ -967,6 +968,7 @@
 			reg = <0x334>;
 			clocks = <&cru SCLK_OTGPHY1>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy2: usb-phy2 {
@@ -974,6 +976,7 @@
 			reg = <0x348>;
 			clocks = <&cru SCLK_OTGPHY2>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 	};
 
-- 
2.6.2

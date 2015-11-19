From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 19 Nov 2015 22:22:27 +0100
Subject: [PATCH v3 6/8] ARM: dts: rockchip: add clock-cells for usb phy nodes
In-Reply-To: <1447968149-10979-1-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
Message-ID: <1447968149-10979-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the #clock-cells properties for the usbphy nodes as they
provide the pll-clocks now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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
index 6a79c9c..9c71b5e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -896,6 +896,7 @@
 			reg = <0x320>;
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy1: usb-phy1 {
@@ -903,6 +904,7 @@
 			reg = <0x334>;
 			clocks = <&cru SCLK_OTGPHY1>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 
 		usbphy2: usb-phy2 {
@@ -910,6 +912,7 @@
 			reg = <0x348>;
 			clocks = <&cru SCLK_OTGPHY2>;
 			clock-names = "phyclk";
+			#clock-cells = <0>;
 		};
 	};
 
-- 
2.6.2

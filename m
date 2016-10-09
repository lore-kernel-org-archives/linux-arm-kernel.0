From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  9 Oct 2016 14:27:13 +0800
Subject: [PATCH v2 3/4] ARM: dts: add battery node for axp20x/axp22x dtsi
In-Reply-To: <20161009062714.5085-1-icenowy@aosc.xyz>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
Message-ID: <20161009062714.5085-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes since v1:
- Add support for AXP20x.

 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index afbe89c..1602987 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -91,6 +91,11 @@
 		};
 	};
 
+	battery: battery {
+		compatible = "x-powers,axp202-battery";
+		status = "disabled";
+	};
+
 	usb_power_supply: usb_power_supply {
 		compatible = "x-powers,axp202-usb-power-supply";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..a09ba3f 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -148,6 +148,11 @@
 		};
 	};
 
+	battery: battery {
+		compatible = "x-powers,axp221-battery";
+		status = "disabled";
+	};
+
 	usb_power_supply: usb_power_supply {
 		compatible = "x-powers,axp221-usb-power-supply";
 		status = "disabled";
-- 
2.10.0

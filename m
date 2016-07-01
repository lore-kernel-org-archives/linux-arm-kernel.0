From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri,  1 Jul 2016 17:29:26 +0800
Subject: [PATCH 4/4] ARM: sun8i: enable axp22x-battery on A23/33 Q8 tablets
In-Reply-To: <20160701092926.32005-1-icenowy@aosc.xyz>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
Message-ID: <20160701092926.32005-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-q8-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index 2e2cbf5..42beec9 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -199,6 +199,10 @@
 	status = "okay";
 };
 
+&battery {
+	status = "okay";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
-- 
2.9.0

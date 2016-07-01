From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri,  1 Jul 2016 17:29:25 +0800
Subject: [PATCH 3/4] ARM: sun8i: add axp20x-battery node for axp22x
In-Reply-To: <20160701092926.32005-1-icenowy@aosc.xyz>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
Message-ID: <20160701092926.32005-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index f05cbf6..4abcac5 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -150,4 +150,9 @@
 		compatible = "x-powers,axp202-usb-power-supply";
 		status = "disabled";
 	};
+
+	battery: battery {
+		compatible = "x-powers,axp202-battery";
+		status = "disabled";
+	};
 };
-- 
2.9.0

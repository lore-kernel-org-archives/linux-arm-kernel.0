From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 19 Jun 2015 02:01:20 +0800
Subject: [RESEND PATCH 5/6] ARM: dts: mt6580: Add device nodes to the MT6580
 dtsi file
In-Reply-To: <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <srv_scott.shu@mediatek.com>
 <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1434650481-39421-6-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT6580 dtsi file.
---
 arch/arm/boot/dts/mt6580.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index ae3cdb6..a974830 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -78,6 +78,11 @@
 		compatible = "simple-bus";
 		ranges;
 
+		scpsys: scpsys at 10006000 {
+			compatible = "mediatek,mt6580-scpsys";
+			reg = <0x10006000 0x1000>;
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt6580-timer", "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
-- 
1.8.1.1.dirty

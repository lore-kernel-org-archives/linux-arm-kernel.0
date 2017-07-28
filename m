From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 28 Jul 2017 18:55:43 +0800
Subject: [PATCH v2 3/3] arm: dts: mediatek: add larbid property for larb
In-Reply-To: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501239343-9190-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1501239343-9190-4-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Add mediatek's hardware id information for smi larb.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index f1efdc6..2cddbec 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -533,6 +533,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x14010000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <0>;
 		clocks = <&mmsys CLK_MM_SMI_LARB0>,
 			 <&mmsys CLK_MM_SMI_LARB0>;
 		clock-names = "apb", "smi";
@@ -549,6 +550,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x15001000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <2>;
 		clocks = <&imgsys CLK_IMG_SMI_COMM>,
 			 <&imgsys CLK_IMG_SMI_COMM>;
 		clock-names = "apb", "smi";
@@ -579,6 +581,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x16010000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <1>;
 		clocks = <&vdecsys CLK_VDEC_CKGEN>,
 			 <&vdecsys CLK_VDEC_LARB>;
 		clock-names = "apb", "smi";
-- 
2.6.4

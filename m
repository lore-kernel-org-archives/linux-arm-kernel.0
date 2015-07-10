From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 10 Jul 2015 14:04:08 +0800
Subject: [PATCH v2 5/6] ARM: dts: mt6580: Add device nodes to the MT6580 dtsi
 file
In-Reply-To: <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <scott.shu@gmail.com>
 <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1436508249-49338-6-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT6580 dtsi file.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/boot/dts/mt6580.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 09852cd..4a9df6a 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -74,6 +74,11 @@
 		};
 	};
 
+	scpsys: scpsys at 10006000 {
+		compatible = "mediatek,mt6580-scpsys";
+		reg = <0x10006000 0x1000>;
+	};
+
 	timer: timer at 10008000 {
 		compatible = "mediatek,mt6580-timer",
 			     "mediatek,mt6577-timer";
-- 
1.8.1.1.dirty

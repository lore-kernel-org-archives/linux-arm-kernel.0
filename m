From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 15 May 2015 23:13:16 +0800
Subject: [PATCH] arm64: dts: mt8173-evb: fix model name
Message-ID: <1431702796-6023-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Model name in mt8173-evb.dtsi doesn't follow dts convention(it should
be human readable model name). Fix it.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 43d5401..d0ab012 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -16,7 +16,8 @@
 #include "mt8173.dtsi"
 
 / {
-	model = "mediatek,mt8173-evb";
+	model = "MediaTek MT8173 evaluation board";
+	compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
 
 	aliases {
 		serial0 = &uart0;
-- 
1.8.1.1.dirty

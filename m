From: andrew-ct.chen@mediatek.com (andrew-ct.chen at mediatek.com)
Date: Fri, 16 Oct 2015 16:39:11 +0800
Subject: [PATCH 3/3] dts: arm64: Add EFUSE device node
In-Reply-To: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <1444984751-4572-4-git-send-email-andrew-ct.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Add Mediatek MT8173 EFUSE device node

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..ab7227a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -258,6 +258,11 @@
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		efuse: efuse at 10206000 {
+			compatible = "mediatek,mt8173-efuse";
+			reg = <0 0x10206000 0 0x1000>;
+		};
+
 		apmixedsys: clock-controller at 10209000 {
 			compatible = "mediatek,mt8173-apmixedsys";
 			reg = <0 0x10209000 0 0x1000>;
-- 
1.9.1

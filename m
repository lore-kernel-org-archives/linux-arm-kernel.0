From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 28 Apr 2015 21:40:34 +0800
Subject: [PATCH v3 3/3] arm64: dts: Add mediatek MT8173 earlycon support
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add earlycon support to mediatek MT8173 evaluation board dts.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 43d5401..d4cf751 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -30,7 +30,9 @@
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
-	chosen { };
+	chosen {
+		linux,stdout-path = &uart0;
+	};
 };
 
 &uart0 {
-- 
1.8.1.1.dirty

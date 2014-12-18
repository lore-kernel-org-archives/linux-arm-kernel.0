From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 18 Dec 2014 16:33:21 +0800
Subject: [PATCH 2/2] arm64: dts: Add mediatek MT8173 earlycon support
In-Reply-To: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1418891601-53769-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add earlycon support to mediatek MT8173 evaluation board dts.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mt8173-evb.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mt8173-evb.dts b/arch/arm64/boot/dts/mt8173-evb.dts
index b8b2621..b8802fd 100644
--- a/arch/arm64/boot/dts/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mt8173-evb.dts
@@ -30,5 +30,7 @@
 		reg = <0 0x40000000 0 0x80000000>;
 	};
 
-	chosen { };
+	chosen {
+		linux,stdout-path = &uart0;
+	};
 };
-- 
1.8.1.1.dirty

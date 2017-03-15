From: yong.mao@mediatek.com (Yong Mao)
Date: Wed, 15 Mar 2017 15:26:39 +0800
Subject: [PATCH v5 2/3] ARM64: dts: mediatek: configure some fixed mmc
 parameters
In-Reply-To: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com>
References: <1489562800-27431-1-git-send-email-yong.mao@mediatek.com>
Message-ID: <1489562800-27431-3-git-send-email-yong.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

configure some fixed mmc parameters

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 0ecaad4..1c3634f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -134,6 +134,9 @@
 	bus-width = <8>;
 	max-frequency = <50000000>;
 	cap-mmc-highspeed;
+	mediatek,hs200-cmd-int-delay=<26>;
+	mediatek,hs400-cmd-int-delay=<14>;
+	mediatek,hs400-cmd-resp-sel-rising;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
-- 
1.7.9.5

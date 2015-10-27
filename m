From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 27 Oct 2015 14:24:27 +0800
Subject: [PATCH v3 07/10] arm64: dts: mediatek: add eMMC hw reset support
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1445927070-5102-8-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add eMMC hardware reset support

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4be66ca..6d79ffc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -72,6 +72,7 @@
 	bus-width = <8>;
 	max-frequency = <50000000>;
 	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
-- 
1.8.1.1.dirty

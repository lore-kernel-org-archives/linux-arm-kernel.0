From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  6 Mar 2018 15:09:13 +0800
Subject: [PATCH] arm64: dts: rockchip: remove keep-power-in-suspend from sdhci
 of rk3399-sapphire
Message-ID: <1520320153-192176-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci for rk3399-sapphire works for eMMC but keep-power-in-suspend
is an optional property for SDIO.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index f7157c1..e5daed7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -541,7 +541,6 @@
 
 &sdhci {
 	bus-width = <8>;
-	keep-power-in-suspend;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
 	non-removable;
-- 
1.9.1

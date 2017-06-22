From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 22 Jun 2017 15:20:52 +0800
Subject: [PATCH v2 4/7] ARM: dts: rockchip: fix compatible string for eMMC
 node of rk3228 SoC
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1498116055-20977-5-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

This adds amend compatible content for eMMC of RK3228 SoC.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 34d175e..c4d43ce 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -523,7 +523,7 @@
 	};
 
 	emmc: dwmmc at 30020000 {
-		compatible = "rockchip,rk3288-dw-mshc";
+		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <37500000>;
-- 
2.0.0

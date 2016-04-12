From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Apr 2016 03:18:39 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable Rockchip displayport phy
Message-ID: <10307860.X4SVE35FiH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The displayport phy controls the output of the Analogix displayport
controller on Rockchip SoCs and is therefore one component to enable
veyron devices to use their internal display.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
to be applied directly to arm-soc

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..66d15ed 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -790,6 +790,7 @@ CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_BERLIN_USB=y
 CONFIG_PHY_BERLIN_SATA=y
+CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
-- 
2.6.4

From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 27 Mar 2018 21:23:27 +0900
Subject: [PATCH] arm64: defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
Message-ID: <1522153407-21430-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the thermal monitor driver and the AVE ethernet driver
implemented on UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1d3b406..4a66e78 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -220,6 +220,7 @@ CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
@@ -343,6 +344,7 @@ CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_QCOM_TSENS=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_TEGRA_BPMP_THERMAL=m
+CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
-- 
2.7.4

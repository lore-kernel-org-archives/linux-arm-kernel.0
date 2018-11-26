From: otavio@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 17:59:04 -0200
Subject: [PATCH v2 1/2] ARM: multi_v7_defconfig: Select PHY_ROCKCHIP_INNO_USB2
Message-ID: <20181126195905.5427-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the CONFIG_PHY_ROCKCHIP_INNO_USB2 option by default, so that
USB can be functional on RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af6234c1b6..a8ec309d182a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -947,6 +947,7 @@ CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_ROCKCHIP_DP=m
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_MIPHY28LP=y
-- 
2.19.2

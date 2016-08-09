From: breno.lima@nxp.com (Breno Lima)
Date: Tue, 9 Aug 2016 15:40:46 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add CONFIG_MPL3115
In-Reply-To: <1470768046-28416-1-git-send-email-breno.lima@nxp.com>
References: <1470768046-28416-1-git-send-email-breno.lima@nxp.com>
Message-ID: <1470768046-28416-2-git-send-email-breno.lima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MPL3115 NXP pressure sensor configuration.

This sensor is used by warp7 board.

Signed-off-by: Breno Lima <breno.lima@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0685d54..73c4c5e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -340,6 +340,7 @@ CONFIG_STAGING=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_VF610_ADC=y
+CONFIG_MPL3115=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
-- 
2.7.4

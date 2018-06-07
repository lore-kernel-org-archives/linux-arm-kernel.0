From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu,  7 Jun 2018 20:00:56 +0300
Subject: [PATCH 2/2] imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors
In-Reply-To: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
Message-ID: <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
CONFIG_MMA8452 supports fsl,mma8451 accelerometer

CONFIG_MAG3110 for fsl,mag3110 is already enabled

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a308437b088..7efcce8083d2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -364,12 +364,14 @@ CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
+CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
+CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
 CONFIG_MPL3115=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
-- 
2.17.1

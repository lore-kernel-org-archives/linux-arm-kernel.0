From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 18 Jun 2018 11:15:45 +0300
Subject: [PATCH v2 2/2] ARM: imx_v6_v7_defconfig: Enable imx6qdl-sabreauto
 sensors
In-Reply-To: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
References: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
Message-ID: <04bf3c71c57201fd89b121a56f1112e233d5adfd.1529309235.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
CONFIG_MMA8452 supports fsl,mma8451 accelerometer

CONFIG_MAG3110 for fsl,mag3110 is already enabled

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
 * Added "ARM:" prefix in title (Fabio)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507ab91ee..a647cbb0e59f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -372,12 +372,14 @@ CONFIG_MXS_DMA=y
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

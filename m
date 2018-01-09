From: marco.franchi@nxp.com (Marco Franchi)
Date: Tue, 9 Jan 2018 09:46:24 -0200
Subject: [PATCH 2/3] ARM: imx: Update imx_v6_v7_defconfig for mag3110 support
In-Reply-To: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
References: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1515498385-23198-2-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 6UL EVK has support for the MAG3110 Magnetometer sensor, included 
in its base board by default.

So add support for this Magnetometer in the imx_v6_v7_defconfig.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4cb9829..ebff980 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -369,6 +369,7 @@ CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
 CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
+CONFIG_MAG3110=y
 CONFIG_MPL3115=y
 CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
-- 
2.7.4

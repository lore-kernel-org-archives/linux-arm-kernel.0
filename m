From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Jan 2016 12:35:07 -0200
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Select CONFIG_NVMEM_IMX_OCOTP
Message-ID: <1454164508-10831-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select the i.mx ocotp driver.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1e792ef..25a6066 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -321,6 +321,8 @@ CONFIG_IIO=y
 CONFIG_VF610_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.9.1

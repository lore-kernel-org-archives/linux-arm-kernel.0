From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Dec 2014 17:30:30 -0200
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select SPI_FSL_QUADSPI by
 default
In-Reply-To: <1418758230-10246-1-git-send-email-festevam@gmail.com>
References: <1418758230-10246-1-git-send-email-festevam@gmail.com>
Message-ID: <1418758230-10246-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SPI_FSL_QUADSPI can be used by Vybrid and mx6sx, so select it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6790f1b..c405a04 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -97,6 +97,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
1.9.1

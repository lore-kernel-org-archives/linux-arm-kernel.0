From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 31 Oct 2018 14:43:33 +0000
Subject: [PATCH V3 10/10] ARM: imx_v6_v7_defconfig: add imx7ulp support
In-Reply-To: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540996688-23681-11-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_SOC_IMX7ULP by default.
Patch generated via make ARCH=arm savedefconfig

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * no changes
v1->v2:
 * rebase to new version
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736..27ee422 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -38,6 +38,7 @@ CONFIG_SOC_IMX6SLL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
+CONFIG_SOC_IMX7ULP=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-- 
2.7.4

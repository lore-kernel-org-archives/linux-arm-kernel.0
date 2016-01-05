From: Frank.Li@nxp.com (Frank Li)
Date: Tue, 5 Jan 2016 11:17:16 -0600
Subject: [PATCH v2 3/4] ARM: imx: config: enable psci default
In-Reply-To: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
References: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <1452014237-12848-3-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

i.MX7D uboot support psci firmware.
Enabled psci default.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
Change from v1 to v2:
 arm to "ARM"

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2d5253d..1e792ef 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -47,6 +47,7 @@ CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
+CONFIG_ARM_PSCI=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-- 
2.5.2

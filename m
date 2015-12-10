From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 11 Dec 2015 07:12:12 +0800
Subject: [PATCH 3/3] arm: imx: config: enable psci default
In-Reply-To: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
References: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1449789132-18976-3-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

i.MX7D uboot support psci firmware.
Enabled psci default.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
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

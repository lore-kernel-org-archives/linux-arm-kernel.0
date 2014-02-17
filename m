From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 17 Feb 2014 14:51:00 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_DEBUG_FS
Message-ID: <1392659460-6821-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_DEBUG_FS is a very useful debug option as it allow us to access key
data such as the clock tree, for example:

mount -t debugfs debugfs /sys/kernel/debug
cat /sys/kernel/debug/clk/clk_summary

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2d5834f..2792842 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -286,6 +286,7 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
+CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_PROVE_LOCKING=y
-- 
1.8.1.2

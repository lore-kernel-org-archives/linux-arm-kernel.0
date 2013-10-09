From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 Oct 2013 20:40:27 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_PROVE_LOCKING
Message-ID: <1381362027-26076-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

This is very useful for detecting 'circular locking dependency' issues.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 137fdb0..e735eb2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -263,6 +263,7 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
+CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
-- 
1.8.1.2

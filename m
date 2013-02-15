From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 15 Feb 2013 15:32:01 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_PERF_EVENTS
Message-ID: <1360949521-16034-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_PERF_EVENTS so that oprofile can be used.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e36b010..12f50c7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -9,6 +9,7 @@ CONFIG_CGROUPS=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
+CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
-- 
1.7.9.5

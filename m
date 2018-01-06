From: shawnguo@kernel.org (Shawn Guo)
Date: Sat,  6 Jan 2018 11:14:33 +0800
Subject: [PATCH v3] ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT
In-Reply-To: <1514004660-32630-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1515208473-20881-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

It is very useful for user to retrieve cpufreq transtion statistics
and worth to be default enabled.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Changes for v3:
 Drop savedefconfig changes which should be a separate patch.

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3b784ed12cc2..4cb9829fccd1 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -55,6 +55,7 @@ CONFIG_FORCE_MAX_ZONEORDER=14
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
-- 
1.9.1

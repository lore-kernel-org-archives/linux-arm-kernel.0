From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Jun 2015 10:46:17 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable kexec support
Message-ID: <1434548777-13703-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_KEXEC by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b47863d..4458554 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -50,6 +50,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMA=y
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
-- 
1.9.1

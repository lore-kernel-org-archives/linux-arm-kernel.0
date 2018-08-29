From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 29 Aug 2018 13:00:47 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE by
 default
In-Reply-To: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some i.MX platforms like i.MX7S/D uses generic ARM cpuidle
driver and psci method to support cpuidle feature, select
CONFIG_ARM_CPUIDLE by default for such platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..65df4b2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -62,6 +62,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
-- 
2.7.4

From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 16 Dec 2013 17:40:20 -0800
Subject: [PATCH 3/3]: Support cpu frequency scaling and power management for
 iMX6SL
Message-ID: <CACUGKYOKEk9RUVS52gGc=CUNFYm1q+zT6rURnB4hwPkC0GCC1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable cpu frequency on imx6 config

From: John Tobias <john.tobias.ph@gmail.com>


diff --git a/arch/arm/configs/imx_v6_v7_defconfig
b/arch/arm/configs/imx_v6_v7_defconfig
index 8d0c5a0..a56cb2c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -43,6 +43,17 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m

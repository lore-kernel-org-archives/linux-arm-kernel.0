From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 15 Aug 2014 15:19:15 +0530
Subject: [PATCH 6/6] arm64: Add support for FSL's LS2085A SoC in Kconfig and
 defconfig
In-Reply-To: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1408096156-29772-7-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for FSL's LS2085A SoC in the arm64 Kconfig
and defconfig files.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
---
 arch/arm64/Kconfig           |    5 +++++
 arch/arm64/configs/defconfig |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 839f48c..72456fe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,11 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_FSL_LS2085A
+	bool "Freescale LS2085A SOC"
+	help
+	  This enables support for Freescale LS2085A SOC.
+
 endmenu
 
 menu "Bus support"
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3421f31..0adb51e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
+CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_KSM=y
-- 
1.7.9.5

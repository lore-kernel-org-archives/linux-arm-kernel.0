From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Oct 2016 17:59:52 +0100
Subject: [PATCH] arm64: Enable HIBERNATION in defconfig
Message-ID: <1476896392-28106-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CONFIG_HIBERNATION to the arm64 defconfig.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Re-sent post 4.9-rc1 as it was missed during the merging window.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0c1f1c..4fc5ae07b035 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
+CONFIG_HIBERNATION=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y

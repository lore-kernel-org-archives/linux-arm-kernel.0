From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Aug 2016 16:28:06 +0100
Subject: [PATCH] arm64: Enable HIBERNATION in defconfig
Message-ID: <1472225286-22032-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CONFIG_HIBERNATION to the arm64 defconfig.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Trivial patch, please apply it when you think it's appropriate.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf4855ad2d..91a7592029e3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -80,6 +80,7 @@ CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
+CONFIG_HIBERNATION=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y

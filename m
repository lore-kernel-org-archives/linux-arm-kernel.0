From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu,  3 Apr 2014 19:16:49 +0800
Subject: [PATCH] ARM64: Remove duplicated Kconfig entry for
 "kernel/power/Kconfig"
Message-ID: <1396523809-6945-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a duplicated Kconfig entry for "kernel/power/Kconfig"
in menu "Power management options" and "CPU Power Management",
remove the one from menu "CPU Power Management" suggested by
Viresh.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6e4d37..e759af5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -323,8 +323,6 @@ menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
-source "kernel/power/Kconfig"
-
 source "drivers/cpufreq/Kconfig"
 
 endmenu
-- 
1.7.9.5

From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Mon, 13 Feb 2012 10:51:22 +0100
Subject: [PATCH] arm: Set ARCH_NR_GPIO to 355 on U8500 platforms
Message-ID: <1329126682-19028-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

This is due to the increased number of AB8500 GPIOs.

Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..f8988d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1579,7 +1579,7 @@ config LOCAL_TIMERS
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 350 if ARCH_U8500
+	default 355 if ARCH_U8500
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 
1.7.6

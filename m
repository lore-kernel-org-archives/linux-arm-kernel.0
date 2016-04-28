From: kamlakant.patel@broadcom.com (kamlakant.patel at broadcom.com)
Date: Thu, 28 Apr 2016 10:32:47 +0530
Subject: [PATCH] arm64: vulcan: enable GPIOLIB in Kconfig
Message-ID: <1461819767-17539-1-git-send-email-kamlakant.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Add select GPIOLIB in Kconfig for Broadcom Vulcan ARM64 GPIO driver.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
---
 arch/arm64/Kconfig.platforms |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index efa77c1..b52a5c3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -161,6 +161,7 @@ config ARCH_VEXPRESS
 
 config ARCH_VULCAN
 	bool "Broadcom Vulcan SOC Family"
+	select GPIOLIB
 	help
 	  This enables support for Broadcom Vulcan SoC Family
 
-- 
1.7.1

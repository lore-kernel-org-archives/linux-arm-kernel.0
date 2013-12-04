From: fkan@apm.com (Feng Kan)
Date: Wed,  4 Dec 2013 10:33:41 -0800
Subject: [PATCH 3/4] arm64: Enable system reset via arch Kconfig for X-Gene
 system.
Message-ID: <1386182021-26678-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enable the system reset via arch Kconfig for X-Gene platforms.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..188e787 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -116,6 +116,7 @@ config ARCH_VEXPRESS
 
 config ARCH_XGENE
 	bool "AppliedMicro X-Gene SOC Family"
+	select POWER_RESET_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
-- 
1.7.6.1

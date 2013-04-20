From: vkale@apm.com (Vinayak Kale)
Date: Sat, 20 Apr 2013 12:45:28 +0530
Subject: [PATCH 1/4] arm64: Add Kconfig option for APM X-Gene SOC family
In-Reply-To: <1366442131-26094-1-git-send-email-vkale@apm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
Message-ID: <1366442131-26094-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds arm64/Kconfig option for APM X-Gene SOC family.

Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43b0e9f..5b8f113 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -114,6 +114,11 @@ config ARCH_VEXPRESS
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
 
+config ARCH_XGENE
+	bool "AppliedMicro X-Gene SOC Family"
+	help
+	  This enables support for AppliedMicro X-Gene SOC Family
+
 endmenu
 
 menu "Bus support"
-- 
1.7.4.1

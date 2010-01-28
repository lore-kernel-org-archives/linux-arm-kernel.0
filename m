From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 28 Jan 2010 09:13:29 +0900
Subject: [PATCH 2/2] ARM: S5PC1XX: Add ARM_L1_CACHE_SHIFT_6 in ARCH_S5PC1XX
Message-ID: <1264637609-15001-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add ARM_L1_CACHE_SHIFT_6 in ARCH_S5PC1XX.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig    |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c7e98ed..4e7d72e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -651,6 +651,7 @@ config ARCH_S5PC1XX
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
 	help
 	  Samsung S5PC1XX series based systems
 
-- 
1.6.2.5

From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:11:52 -0800
Subject: [PATCH 1/7] OMAP: Kconfig: select GENERIC_CLK
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Message-ID: <1323835918-2371-2-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e1293aa..921451c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select GENERIC_CLK
 	help
 	  Compile a kernel suitable for booting most boards
 
-- 
1.7.5.4

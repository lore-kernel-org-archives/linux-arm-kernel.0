From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Thu, 28 Jul 2011 21:34:41 +0800
Subject: [PATCH] ARM: EXYNOS4: remove duplicated #include
Message-ID: <1311860081-996-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-exynos4/cpu.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-exynos4/cpu.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 2d8a40c..84032d3 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -24,7 +24,6 @@
 #include <plat/exynos4.h>
 #include <plat/adc-core.h>
 #include <plat/sdhci.h>
-#include <plat/devs.h>
 #include <plat/fb-core.h>
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
-- 
1.5.6.4

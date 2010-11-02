From: eric.y.miao@gmail.com (eric.y.miao at gmail.com)
Date: Tue,  2 Nov 2010 21:30:49 +0800
Subject: [PATCH 2/2] ARM: pxa/saar: fix the building failure caused by typo
Message-ID: <1288704649-3026-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.y.miao@gmail.com>

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/saar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 2e2f5a3..c1ca8cb 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -116,7 +116,7 @@ static struct platform_device smc91x_device = {
 	},
 };
 
-#if defined(CONFIG_FB_PXA) || (CONFIG_FB_PXA_MODULE)
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static uint16_t lcd_power_on[] = {
 	/* single frame */
 	SMART_CMD_NOOP,
-- 
1.7.1

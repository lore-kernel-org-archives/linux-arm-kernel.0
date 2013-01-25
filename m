From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:39 +0900
Subject: [PATCH 03/80] sh: sh7723: Rename GPIO_FN_SIUOSPD to GPIO_FN_SIUAOSPD
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The GPIO was incorrectly named. As it has no user in the whole kernel
tree, just rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/include/cpu-sh4/cpu/sh7723.h    |    2 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7723.h b/arch/sh/include/cpu-sh4/cpu/sh7723.h
index 6fae50c..668da89 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7723.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7723.h
@@ -184,7 +184,7 @@ enum {
 	/* SIUA */
 	GPIO_FN_SIUAFCK, GPIO_FN_SIUAILR, GPIO_FN_SIUAIBT, GPIO_FN_SIUAISLD,
 	GPIO_FN_SIUAOLR, GPIO_FN_SIUAOBT, GPIO_FN_SIUAOSLD, GPIO_FN_SIUAMCK,
-	GPIO_FN_SIUAISPD, GPIO_FN_SIUOSPD,
+	GPIO_FN_SIUAISPD, GPIO_FN_SIUAOSPD,
 
 	/* SIUB */
 	GPIO_FN_SIUBFCK, GPIO_FN_SIUBILR, GPIO_FN_SIUBIBT, GPIO_FN_SIUBISLD,
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
index 88bf5ec..2037915 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
@@ -1317,7 +1317,7 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_FN_SIUAOSLD, SIUAOSLD_MARK),
 	PINMUX_GPIO(GPIO_FN_SIUAMCK, SIUAMCK_MARK),
 	PINMUX_GPIO(GPIO_FN_SIUAISPD, SIUAISPD_MARK),
-	PINMUX_GPIO(GPIO_FN_SIUOSPD, SIUAOSPD_MARK),
+	PINMUX_GPIO(GPIO_FN_SIUAOSPD, SIUAOSPD_MARK),
 
 	/* SIUB */
 	PINMUX_GPIO(GPIO_FN_SIUBFCK, SIUBFCK_MARK),
-- 
1.7.10.4

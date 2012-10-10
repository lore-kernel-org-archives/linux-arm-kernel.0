From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Oct 2012 16:18:50 +0100
Subject: [PATCH 1/6] ARM: ux500: Remove unused board compatible string
In-Reply-To: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349882335-6786-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'st-ericsson,u8500' is too much of a broad name to be used for
any of the supported development boards supported by ST-Ericsson.
As such it was never used. It has no place to remain in the board
compatible list, hence why it's being removed.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 9f87b4d..3d8e321 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -330,7 +330,6 @@ static void __init u8500_init_machine(void)
 static const char * u8500_dt_board_compat[] = {
 	"calaosystems,snowball-a9500",
 	"st-ericsson,hrefv60+",
-	"st-ericsson,u8500",
 	"st-ericsson,mop500",
 	NULL,
 };
-- 
1.7.9.5

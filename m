From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:26:29 +0200
Subject: [PATCH] mach-x500: fix SECTION warnings in uib
Message-ID: <1308741989-22938-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Marklund <robert.marklund@stericsson.com>

Fix some simple section warning noise.

Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-uib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 69cce41..5af36aa 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -25,7 +25,7 @@ struct uib {
 	void (*init)(void);
 };
 
-static struct __initdata uib mop500_uibs[] = {
+static struct uib __initdata mop500_uibs[] = {
 	[STUIB] = {
 		.name	= "ST-UIB",
 		.option	= "stuib",
-- 
1.7.3.2

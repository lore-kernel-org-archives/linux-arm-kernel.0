From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:32 +0200
Subject: [RFC PATCH 02/15] ARM: uncompress: Remove unused definition of
	ARCH_HAS_DECOMP_WATCHDOG
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-2-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was only used by the old inflate code, which isn't used
anymore by ARM.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/decompress.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 07be5a2..75b1605 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -13,8 +13,6 @@ extern void error(char *);
 #define STATIC static
 #define STATIC_RW_DATA	/* non-static please */
 
-#define ARCH_HAS_DECOMP_WDOG
-
 /* Diagnostic functions */
 #ifdef DEBUG
 #  define Assert(cond,msg) {if(!(cond)) error(msg);}
-- 
1.7.4.1

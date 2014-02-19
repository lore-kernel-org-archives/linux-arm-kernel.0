From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 19 Feb 2014 21:20:52 +0100
Subject: [PATCH 2/2] ARM: efm32: drop unused file <mach/timex.h>
In-Reply-To: <1392841252-25918-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20140219201950.GC6988@pengutronix.de>
 <1392841252-25918-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1392841252-25918-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file is unused since commit

	79f08d9ed217 (ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too)

.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-efm32/include/mach/timex.h | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 arch/arm/mach-efm32/include/mach/timex.h

diff --git a/arch/arm/mach-efm32/include/mach/timex.h b/arch/arm/mach-efm32/include/mach/timex.h
deleted file mode 100644
index 7a8b26da6599..000000000000
--- a/arch/arm/mach-efm32/include/mach/timex.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * Empty file waiting for deletion once <mach/timex.h> isn't needed any more.
- */
-- 
1.8.5.3

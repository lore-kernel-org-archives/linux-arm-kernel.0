From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 19 Feb 2014 21:20:51 +0100
Subject: [PATCH 1/2] ARM: efm32: drop unused file entry-macro.S
In-Reply-To: <20140219201950.GC6988@pengutronix.de>
References: <20140219201950.GC6988@pengutronix.de>
Message-ID: <1392841252-25918-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file is unused since commit

	e6d159cdf9f7 (ARM: 7890/1: v7-M: drop using mach/entry-macro.S)

which went into v3.14-rc1.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-efm32/include/mach/entry-macro.S | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S

diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
deleted file mode 100644
index 322159d5ed91..000000000000
--- a/arch/arm/mach-efm32/include/mach/entry-macro.S
+++ /dev/null
@@ -1,4 +0,0 @@
-/*
- * Empty file waiting for deletion once <mach/entry-macro.S> isn't needed any
- * more. Patch "ARM: v7-M: drop using mach/entry-macro.S" sitting in next.
- */
-- 
1.8.5.3

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jul 2013 09:12:52 +0200
Subject: [PATCH] ARM: sunxi: Remove Makefile.boot file
Message-ID: <1374649972-26088-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we've been a multi-platform enabled kernel from the beginning,
Makefile.boot has always been dead code.

Remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Makefile.boot | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-sunxi/Makefile.boot

diff --git a/arch/arm/mach-sunxi/Makefile.boot b/arch/arm/mach-sunxi/Makefile.boot
deleted file mode 100644
index 46d4cf0..0000000
--- a/arch/arm/mach-sunxi/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-$(CONFIG_ARCH_SUNXI)	+= 0x40008000
-- 
1.8.3.2

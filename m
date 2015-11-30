From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Dec 2015 00:00:57 +0100
Subject: [PATCH 6/7] ARM: mvebu: remove unused mach/gpio.h
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Message-ID: <1448924458-3279040-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file was left over from a cleanup of asm/gpio.h and has
not been used in a while. Let's just remove it now, so the
arch/arm/mach-mvebu/include/ directory can also disappear.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mvebu/include/mach/gpio.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h

diff --git a/arch/arm/mach-mvebu/include/mach/gpio.h b/arch/arm/mach-mvebu/include/mach/gpio.h
deleted file mode 100644
index 40a8c178f10d..000000000000
--- a/arch/arm/mach-mvebu/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
-- 
2.1.0.rc2

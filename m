From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 16:23:12 +0200
Subject: [PATCH 5/5] AVR32: Remove HAVE_NET_MACB
In-Reply-To: <1350829392-3812-1-git-send-email-manabian@gmail.com>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
Message-ID: <1350829392-3812-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HAVE_NET_MACB has already been removed from the driver itself
so removed it from arch Kconfig as well.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/avr32/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 06e73bf..09f9fa8 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -80,7 +80,6 @@ config PLATFORM_AT32AP
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_ALLOCATOR
 	select HAVE_FB_ATMEL
-	select HAVE_NET_MACB
 
 #
 # CPU types
-- 
1.7.12.4

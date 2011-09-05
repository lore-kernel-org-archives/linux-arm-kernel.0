From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon,  5 Sep 2011 21:59:08 +0200
Subject: [PATCH] ARM: Footbridge: Sort KConfig Options alphabetically
Message-ID: <1315252748-5689-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per request of rmk, the options should be sorted alphabetically.

KernelVersion: Linux next-20110831

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-footbridge/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index c8e7afc..f643ef8 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -4,8 +4,8 @@ menu "Footbridge Implementations"
 
 config ARCH_CATS
 	bool "CATS"
-	select CLKSRC_I8253
 	select CLKEVT_I8253
+	select CLKSRC_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
@@ -61,8 +61,8 @@ config ARCH_EBSA285_HOST
 
 config ARCH_NETWINDER
 	bool "NetWinder"
-	select CLKSRC_I8253
 	select CLKEVT_I8253
+	select CLKSRC_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
-- 
1.7.3.4

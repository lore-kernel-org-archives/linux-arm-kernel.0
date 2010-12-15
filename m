From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:01 +0100
Subject: [PATCH 03/16] ARM: Remove some spurious mach dir includes.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020301.GV15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/include/asm/mc146818rtc.h |    1 -
 arch/arm/plat-orion/pcie.c         |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mc146818rtc.h b/arch/arm/include/asm/mc146818rtc.h
index 6b884d2..d535470 100644
--- a/arch/arm/include/asm/mc146818rtc.h
+++ b/arch/arm/include/asm/mc146818rtc.h
@@ -5,7 +5,6 @@
 #define _ASM_MC146818RTC_H
 
 #include <linux/io.h>
-#include <mach/irqs.h>
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index af2d733..cf670f3 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/mbus.h>
-#include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <linux/delay.h>
 
-- 
1.7.1

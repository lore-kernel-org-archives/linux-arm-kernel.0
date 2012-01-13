From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:04 -0600
Subject: [RFC PATCH 03/10] ARM: mc146818rtc: remove unnecessary include of
 mach/irqs.h
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The include of mach/irqs.h isn't needed, so remove it. Compiled CMOS rtc
driver.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mc146818rtc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
-- 
1.7.5.4

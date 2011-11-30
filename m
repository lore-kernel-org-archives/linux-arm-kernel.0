From: rusko.peter@prolan.hu (Peter Rusko)
Date: Wed, 30 Nov 2011 16:43:27 +0100
Subject: [PATCH] mx28: LRADC macro rename
Message-ID: <1322667807-8097-1-git-send-email-rusko.peter@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a correction of two macro names, renaming them from IRADC to LRADC.

Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
---
 arch/arm/mach-mxs/include/mach/mx28.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
index 75d8611..30c7990 100644
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -104,8 +104,8 @@
 #define MX28_INT_CAN1			9
 #define MX28_INT_LRADC_TOUCH		10
 #define MX28_INT_HSADC			13
-#define MX28_INT_IRADC_THRESH0		14
-#define MX28_INT_IRADC_THRESH1		15
+#define MX28_INT_LRADC_THRESH0		14
+#define MX28_INT_LRADC_THRESH1		15
 #define MX28_INT_LRADC_CH0		16
 #define MX28_INT_LRADC_CH1		17
 #define MX28_INT_LRADC_CH2		18
-- 
1.7.5.4

From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  5 Jan 2011 05:05:06 +0300
Subject: [PATCH 2/6] mfp-pxa27x: correct naming of GPIO13_KP_DKIN_7
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1294193110-23958-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct naming of one of pin functions: it's GPIO13_KP_DKIN_7, not
GPIO13_KP_KDIN_7.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
index ec0f0b0..6553d62 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
@@ -300,7 +300,7 @@
 #define GPIO97_KP_DKIN_4	MFP_CFG_IN(GPIO97, AF1)
 #define GPIO98_KP_DKIN_5	MFP_CFG_IN(GPIO98, AF1)
 #define GPIO99_KP_DKIN_6	MFP_CFG_IN(GPIO99, AF1)
-#define GPIO13_KP_KDIN_7	MFP_CFG_IN(GPIO13, AF2)
+#define GPIO13_KP_DKIN_7	MFP_CFG_IN(GPIO13, AF2)
 #define GPIO100_KP_MKIN_0	MFP_CFG_IN(GPIO100, AF1)
 #define GPIO101_KP_MKIN_1	MFP_CFG_IN(GPIO101, AF1)
 #define GPIO102_KP_MKIN_2	MFP_CFG_IN(GPIO102, AF1)
-- 
1.7.2.3

From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 9 Jun 2014 18:13:44 +0300
Subject: [patch] [ARM] pxa: remove duplicate SM_SCLK_SM_SCLK define
Message-ID: <20140609151343.GH9600@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SM_SCLK_SM_SCLK is define is cut and pasted twice.  I have removed
the second define.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
index fbd7ee8..8c78f2b1 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
@@ -23,7 +23,6 @@
 #define SM_nCS0_nCS0		MFP_CFG(SM_nCS0, AF0)
 #define SM_ADV_SM_ADV		MFP_CFG(SM_ADV, AF0)
 #define SM_SCLK_SM_SCLK		MFP_CFG(SM_SCLK, AF0)
-#define SM_SCLK_SM_SCLK		MFP_CFG(SM_SCLK, AF0)
 #define SM_BE0_SM_BE0		MFP_CFG(SM_BE0, AF1)
 #define SM_BE1_SM_BE1		MFP_CFG(SM_BE1, AF1)
 

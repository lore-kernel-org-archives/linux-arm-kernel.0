From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 29 Sep 2010 18:11:14 +0900
Subject: Request: Update the Universal board to use the correct machine name
Message-ID: <20100929091114.GA21218@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

As previous time, Kgene suggestted to use the universal_c210 but mach-types file is not yet updated. It makes compile error can't make a image.

Could you update the mach-types?

Thank you,
Kyungmin Park

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 55590a4..787891e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -2971,7 +2971,7 @@ premierwave_en		MACH_PREMIERWAVE_EN	PREMIERWAVE_EN		2985
 wasabi			MACH_WASABI		WASABI			2986
 vivow			MACH_VIVOW		VIVOW			2987
 mx50_rdp		MACH_MX50_RDP		MX50_RDP		2988
-universal		MACH_UNIVERSAL		UNIVERSAL		2989
+universal_c210		MACH_UNIVERSAL_C210	UNIVERSAL_C210		2989
 real6410		MACH_REAL6410		REAL6410		2990
 spx_sakura		MACH_SPX_SAKURA		SPX_SAKURA		2991
 ij3k_2440		MACH_IJ3K_2440		IJ3K_2440		2992

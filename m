From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 27 Nov 2014 17:51:39 +0200
Subject: [PATCH 08/23] ARM: OMAP3+: PRM: remove prm_get_reset_sources
 declaration from headers
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Message-ID: <1417103514-17027-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no implementation for this anywhere, so remove it from the header
files also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.h      |    1 -
 arch/arm/mach-omap2/prm44xx_54xx.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 17abe43..5a09a74 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -145,7 +145,6 @@ extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 extern int __init omap3xxx_prm_init(void);
-extern u32 omap3xxx_prm_get_reset_sources(void);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index f751251..7143295 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -39,7 +39,6 @@ extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 extern int __init omap44xx_prm_init(void);
-extern u32 omap44xx_prm_get_reset_sources(void);
 
 #endif
 
-- 
1.7.9.5

From: Nicolae_Rosia@mentor.com (Nicolae Rosia)
Date: Tue, 1 Nov 2016 13:36:44 +0200
Subject: [PATCH 3/5] ARM: OMAP3: kill omap3_pmic_init
In-Reply-To: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <1478000206-10855-4-git-send-email-Nicolae_Rosia@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove dead code

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/twl-common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 048f6b2..397722d 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -45,12 +45,6 @@ static inline void omap2_pmic_init(const char *pmic_type,
 	omap_pmic_init(2, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
 }
 
-static inline void omap3_pmic_init(const char *pmic_type,
-				   struct twl4030_platform_data *pmic_data)
-{
-	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
-}
-
 void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
 
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
2.5.5

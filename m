From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri,  4 Jun 2010 03:07:32 +0200
Subject: [PATCH 1/3] pxa/colibri270: Fix typo in colibri_pxa270_flash
Message-ID: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append colibri_pxa270_flash(_device). This was missing.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa270.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 96ce4ae..98673ac 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -99,7 +99,7 @@ static struct platform_device colibri_pxa270_flash_device = {
 
 static void __init colibri_pxa270_nor_init(void)
 {
-	platform_device_register(&colibri_pxa270_flash);
+	platform_device_register(&colibri_pxa270_flash_device);
 }
 #else
 static inline void colibri_pxa270_nor_init(void) {}
-- 
1.7.1

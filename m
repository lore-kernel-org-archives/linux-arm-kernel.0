From: zonque@gmail.com (Daniel Mack)
Date: Fri, 17 Jun 2011 17:21:50 +0200
Subject: [PATCH] ARM: OMAP: Overo: remove illegal extra call to
	overo_ads7846_init()
Message-ID: <1308324110-21918-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/board-overo.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..110475f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -568,7 +568,6 @@ static void __init overo_init(void)
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
-	overo_ads7846_init();
 	overo_init_smsc911x();
 	overo_display_init();
 	overo_init_led();
-- 
1.7.5.1

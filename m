From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:35:30 +0200
Subject: [PATCH 5/6] mach-ux500: Kconfig for snowball board
Message-ID: <1308742530-25097-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

This adds the necessary Kconfig entry for a Snowball board.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 96d546c..4210cb4 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -35,6 +35,13 @@ config MACH_HREFV60
        help
          Include support for the HREFv60 new development platform.
 
+config MACH_SNOWBALL
+	bool "U8500 Snowball platform"
+	depends on UX500_SOC_DB8500
+	select MACH_U8500
+	help
+	  Include support for the snowball development platform.
+
 config MACH_U5500
 	bool "U5500 Development platform"
 	depends on UX500_SOC_DB5500
-- 
1.7.3.2

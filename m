From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:35 +0200
Subject: [PATCH 01/19] wip: enable DEBUG_SECTION_MISMATCH
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dfdc034..a73e004 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -103,7 +103,7 @@ config HEADERS_CHECK
 
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
-	depends on UNDEFINED || (BLACKFIN)
+	depends on BLACKFIN || ARM
 	default y
 	# This option is on purpose disabled for now.
 	# It will be enabled when we are down to a reasonable number
-- 
1.7.1

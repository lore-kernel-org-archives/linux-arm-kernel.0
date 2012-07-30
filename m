From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Jul 2012 18:38:34 +0200
Subject: [PATCH 2/2] MAINTAINERS: fix a few pinctrl related entries
In-Reply-To: <1343666314-18070-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343666314-18070-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343666314-18070-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe643e7..32d57e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5296,14 +5296,15 @@ PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 F:	drivers/pinctrl/
+F:	include/linux/pinctrl/
 
 PIN CONTROLLER - ST SPEAR
-M:     Viresh Kumar <viresh.linux@gmail.com>
+M:	Viresh Kumar <viresh.linux@gmail.com>
 L:	spear-devel at list.st.com
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
-F:	driver/pinctrl/spear/
+F:	drivers/pinctrl/spear/
 
 PKTCDVD DRIVER
 M:	Peter Osterlund <petero2@telia.com>
-- 
1.7.10.4

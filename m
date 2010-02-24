From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 12:01:46 +0100
Subject: [PATCH 3/3] MAINTAINERS: add i2c tree for embedded platforms
In-Reply-To: <20100224110044.GB15181@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de>
Message-ID: <1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2533fc4..a3c936c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2626,6 +2626,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
 L:	linux-i2c at vger.kernel.org
 W:	http://i2c.wiki.kernel.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
+T:	git git://git.fluff.org/bjdooks/linux.git
 S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
-- 
1.6.6.2

From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Mar 2010 12:12:16 +0100
Subject: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
In-Reply-To: <20100301113840.4d6b4e7d@hyperion.delvare>
References: <20100301113840.4d6b4e7d@hyperion.delvare>
Message-ID: <1267441936-4432-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f520dd0..a01745b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2658,6 +2658,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
 L:	linux-i2c at vger.kernel.org
 W:	http://i2c.wiki.kernel.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
+T:	git git://git.fluff.org/bjdooks/linux.git next-i2c
 S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
-- 
1.7.0

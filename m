From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Nov 2009 16:53:24 +0100
Subject: [PATCH v2] MAINTAINERS: add tree and file pattern for ARM IMX
In-Reply-To: <1259596034-18167-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259596034-18167-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1259596404-19131-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Hello,

in the first patch I forgot a trailing slash for arch/arm/plat-mxc/.

Best regards
Uwe

 MAINTAINERS |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c824b4d..d40cf36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -637,6 +637,9 @@ ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
 M:	Sascha Hauer <kernel@pengutronix.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+T:	git://git.pengutronix.de/git/imx/linux-2.6.git
+F:	arch/arm/mach-mx*/
+F:	arch/arm/plat-mxc/
 
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.6.5.2

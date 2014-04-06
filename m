From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun,  6 Apr 2014 16:58:17 +0200
Subject: [PATCH 5/5] MAINTAINERS: update GPIO OMAP driver entry
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1396796297-13002-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been maintaining this driver by fixing all issues
found while migrating OMAP2+ towards Device Tree based
booting and keeping it up-to-date by using the latest
infraestructure that is provided by the GPIO subsystem.

It would be nice if people know that I care about this
driver and put me in copy when sending patches for it.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f728ac2..fc0972e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6374,6 +6374,7 @@ F:	drivers/usb/*/*omap*
 F:	arch/arm/*omap*/usb*
 
 OMAP GPIO DRIVER
+M:	Javier Martinez Canillas <javier@dowhile0.org>
 M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
 M:	Kevin Hilman <khilman@deeprootsystems.com>
 L:	linux-omap at vger.kernel.org
-- 
1.9.0

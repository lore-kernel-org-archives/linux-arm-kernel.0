From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Fri, 23 Nov 2012 22:26:42 -0200
Subject: [PATCH 18/24] MAINTAINERS: remove drivers/mmc/host/imxmmc.*
In-Reply-To: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1353716808-16375-19-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver was removed by commit 6187fee (mmc: remove imxmmc driver).

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pavel Pisa <ppisa@pikron.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc646ef..cac8e49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4905,12 +4905,6 @@ F:	Documentation/video4linux/meye.txt
 F:	drivers/media/pci/meye/
 F:	include/uapi/linux/meye.h
 
-MOTOROLA IMX MMC/SD HOST CONTROLLER INTERFACE DRIVER
-M:	Pavel Pisa <ppisa@pikron.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/mmc/host/imxmmc.*
-
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@gmail.com>
 S:	Maintained
-- 
1.7.11.7

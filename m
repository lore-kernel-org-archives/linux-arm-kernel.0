From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Sep 2018 12:00:18 +0200
Subject: [PATCH v2 4/4] MAINTAINERS: add entry for i.MX PXP media mem2mem
 driver
In-Reply-To: <20180905100018.27556-1-p.zabel@pengutronix.de>
References: <20180905100018.27556-1-p.zabel@pengutronix.de>
Message-ID: <20180905100018.27556-5-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..2e23c644f5d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8994,6 +8994,13 @@ F:	drivers/staging/media/imx/
 F:	include/linux/imx-media.h
 F:	include/media/imx.h
 
+MEDIA DRIVER FOR FREESCALE IMX PXP
+M:	Philipp Zabel <p.zabel@pengutronix.de>
+L:	linux-media at vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/platform/imx-pxp.[ch]
+
 MEDIA DRIVERS FOR HELENE
 M:	Abylay Ospan <aospan@netup.ru>
 L:	linux-media at vger.kernel.org
-- 
2.18.0

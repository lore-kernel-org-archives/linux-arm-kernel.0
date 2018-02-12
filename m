From: stefan@agner.ch (Stefan Agner)
Date: Mon, 12 Feb 2018 16:05:49 +0100
Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
Message-ID: <20180212150549.8622-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
and the Pengutronix kernel team as reviewer.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..df60ca7c3355 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10768,6 +10768,17 @@ L:	linux-gpio at vger.kernel.org
 S:	Supported
 F:	drivers/pinctrl/pinctrl-at91-pio4.*
 
+PIN CONTROLLER - FREESCALE
+M:	Dong Aisheng <aisheng.dong@nxp.com>
+M:	Fabio Estevam <festevam@gmail.com>
+M:	Shawn Guo <shawnguo@kernel.org>
+M:	Stefan Agner <stefan@agner.ch>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-gpio at vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/freescale/*
+F:	Documentation/devicetree/bindings/pinctrl/fsl,*
+
 PIN CONTROLLER - INTEL
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-- 
2.16.1

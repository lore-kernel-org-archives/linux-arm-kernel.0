From: stefan@agner.ch (Stefan Agner)
Date: Tue, 20 Feb 2018 23:55:46 +0100
Subject: [PATCH v4] MAINTAINERS: add Freescale pin controllers
Message-ID: <20180220225546.15987-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
and the Pengutronix kernel team as reviewer.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..ac007ea02d54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10926,6 +10926,17 @@ L:	linux-gpio at vger.kernel.org
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
+F:	drivers/pinctrl/freescale/
+F:	Documentation/devicetree/bindings/pinctrl/fsl,*
+
 PIN CONTROLLER - INTEL
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-- 
2.16.2

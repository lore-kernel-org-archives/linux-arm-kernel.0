From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu, 27 Oct 2016 15:01:54 +0200
Subject: [PATCH V6 2/4] MAINTAINERS: Add entry for GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <cover.1477572814.git.peter.senna@collabora.com>
References: <cover.1477572814.git.peter.senna@collabora.com>
Message-ID: <80df3e0417dc27713287ebb37136836b443c873e.1477572814.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the MAINTAINERS file for the GE B850v3 LVDS/DP++ Bridge.

Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Martin Donnelly <martin.donnelly@ge.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
CC: David Airlie <airlied@linux.ie>
CC: Thierry Reding <treding@nvidia.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6834df3..23100f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5249,6 +5249,14 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-gemtek*
 
+GENERAL ELECTRIC B850V3 LVDS/DP++ BRIDGE
+M:	Peter Senna Tschudin <peter.senna@collabora.com>
+M:	Martin Donnelly <martin.donnelly@ge.com>
+M:	Martyn Welch <martyn.welch@collabora.co.uk>
+S:	Maintained
+F:	drivers/gpu/drm/bridge/ge_b850v3_dp2.c
+F:	Documentation/devicetree/bindings/ge/b850v3_dp2_bridge.txt
+
 GENERIC GPIO I2C DRIVER
 M:	Haavard Skinnemoen <hskinnemoen@gmail.com>
 S:	Supported
-- 
2.5.5

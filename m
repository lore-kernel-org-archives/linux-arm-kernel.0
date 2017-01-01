From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Sun,  1 Jan 2017 21:24:30 +0100
Subject: [PATCH V7 2/4] MAINTAINERS: Add entry for GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <cover.1483301745.git.peter.senna@collabora.com>
References: <cover.1483301745.git.peter.senna@collabora.com>
Message-ID: <597f32d0aac5f87b88b88d99b2e8622ffe71a165.1483301745.git.peter.senna@collabora.com>
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
index fdd9d5e3..1d3f17a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5371,6 +5371,14 @@ W:	https://linuxtv.org
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

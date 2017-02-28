From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Tue, 28 Feb 2017 15:28:11 +0100
Subject: [PATCH V2 2/4] MAINTAINERS: Add entry for
 megachips-stdpxxxx-ge-b850v3-fw
In-Reply-To: <cover.1488287639.git.peter.senna@collabora.com>
References: <cover.1488287639.git.peter.senna@collabora.com>
Message-ID: <14d5b25144f379c2a44523d613a6fab75073be80.1488287639.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAINTAINERS entry for the second video output of the GE B850v3:
       STDP4028-ge-b850v3-fw bridges (LVDS-DP)
       STDP2690-ge-b850v3-fw bridges (DP-DP++)

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Unchanged from V1

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d97b1d..5f30b17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8129,6 +8129,14 @@ L:	linux-wireless at vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/mediatek/mt7601u/
 
+MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
+M:	Peter Senna Tschudin <peter.senna@collabora.com>
+M:	Martin Donnelly <martin.donnelly@ge.com>
+M:	Martyn Welch <martyn.welch@collabora.co.uk>
+S:	Maintained
+F:	drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+F:	Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
+
 MEGARAID SCSI/SAS DRIVERS
 M:	Kashyap Desai <kashyap.desai@broadcom.com>
 M:	Sumit Saxena <sumit.saxena@broadcom.com>
-- 
2.9.3

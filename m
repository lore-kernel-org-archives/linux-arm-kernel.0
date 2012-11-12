From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Mon, 12 Nov 2012 23:33:40 +0100
Subject: [PATCH] Fix typo in DT binding documentation for i.MX IPU3
Message-ID: <20121112223340.20867.75319.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

crtc should be crtcs in parallel display.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 07654f0..68eff34 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -23,7 +23,7 @@ Parallel display support
 
 Required properties:
 - compatible: Should be "fsl,imx-parallel-display"
-- crtc: the crtc this display is connected to, see below
+- crtcs: the crtc this display is connected to, see below
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
   crtc. Currently supported types: "rgb24", "rgb565"
@@ -36,6 +36,6 @@ example:
 display at di0 {
 	compatible = "fsl,imx-parallel-display";
 	edid = [edid-data];
-	crtc = <&ipu 0>;
+	crtcs = <&ipu 0>;
 	interface-pix-fmt = "rgb24";
 };

From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:37:22 +0200
Subject: [PATCH 0015/1529] Fix typo
Message-ID: <20160521113722.32053-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d..616428a 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -8,7 +8,7 @@ use to analyze system performance, to make behaviors visible and to count
 usages of each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).
 The Exynos PPMU driver uses the devfreq-event class to provide event data
 to various devfreq devices. The devfreq devices would use the event data when
-derterming the current state of each IP.
+determing the current state of each IP.
 
 Required properties:
 - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
-- 
2.8.2.534.g1f66975

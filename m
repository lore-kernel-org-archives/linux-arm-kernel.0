From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 28 Dec 2016 19:50:25 +0200
Subject: [RESEND v2] dt-bindings: video: exynos7-decon: Remove obsolete
 samsung, power-domain property
Message-ID: <20161228175025.5581-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung,power-domain property is obsolete since commit 0da658704136
("ARM: dts: convert to generic power domain bindings for exynos DT").
Replace it with generic one.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Just add the acks/reviews.

I though it will be applied by Exynos DRM maintainer but there was no
response.
Dear Rob, could you pick it up?
---
 Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt b/Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
index 3938caacf11c..8346fb18a358 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
@@ -33,7 +33,7 @@ Required properties:
 - i80-if-timings: timing configuration for lcd i80 interface support.
 
 Optional Properties:
-- samsung,power-domain: a phandle to DECON power domain node.
+- power-domains: a phandle to DECON power domain node.
 - display-timings: timing settings for DECON, as described in document [1].
 		Can be used in case timings cannot be provided otherwise
 		or to override timings provided by the panel.
-- 
2.9.3

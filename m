From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 21 Oct 2016 17:05:54 +0300
Subject: [PATCH] dt-bindings: video: exynos7-decon: Remove obsolete samsung,
 power-domain property
Message-ID: <1477058754-13866-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung,power-domain property is obsolete since commit 0da658704136
("ARM: dts: convert to generic power domain bindings for exynos DT").
Replace it with generic one.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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
2.7.4

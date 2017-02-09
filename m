From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:20 +0100
Subject: [PATCH 6/8] dt-bindings: gpu: mali: Add optional OPPs
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <29cb6b892a6e7002d2f6271157a5efa648b0dd9b.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The operating-points-v2 binding gives a way to provide the OPP of the GPU.
Let's use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
 1 file changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 88df4a276607..2b6243e730f6 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -39,6 +39,10 @@ Optional properties:
     Memory region to allocate from, as defined in
     Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
 
+  - operating-points-v2:
+    Operating Points for the GPU, as defined in
+    Documentation/devicetree/bindings/opp/opp.txt
+
 Vendor-specific bindings
 ------------------------
 
-- 
git-series 0.8.11

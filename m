From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:16 +0100
Subject: [PATCH 2/8] dt-bindings: gpu: mali: Add optional memory-region
In-Reply-To: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <49fd36f667c5ae46b0724c8204eabc51014aab92.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reserved memory bindings allow us to specify which memory areas our
buffers can be allocated from.

Let's use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
 1 file changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 476f5ea6c627..88df4a276607 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -35,6 +35,10 @@ Optional properties:
   - interrupt-names and interrupts:
     * pmu: Power Management Unit interrupt, if implemented in hardware
 
+  - memory-region:
+    Memory region to allocate from, as defined in
+    Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
+
 Vendor-specific bindings
 ------------------------
 
-- 
git-series 0.8.11

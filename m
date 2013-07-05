From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri,  5 Jul 2013 14:12:28 +0530
Subject: [PATCH 2/3] of/documentation: Update G2D documentation
In-Reply-To: <1373013749-14530-1-git-send-email-sachin.kamat@linaro.org>
References: <1373013749-14530-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1373013749-14530-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5250 G2D IP requires only the gate clock. Update the
binding documentation accordingly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Inki Dae <inki.dae@samsung.com>
---
 .../devicetree/bindings/gpu/samsung-g2d.txt        |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
index 3f454ff..60ca631 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
@@ -12,7 +12,9 @@ Required properties:
   - interrupts : G2D interrupt number to the CPU.
   - clocks : from common clock binding: handle to G2D clocks.
   - clock-names : from common clock binding: must contain "sclk_fimg2d" and
-		  "fimg2d", corresponding to entries in the clocks property.
+		  "fimg2d" for S5PV210 & Exynos4 based SoCs and "fimg2d" for
+		  Exynos5250 SoC, corresponding to entries in the clocks
+		  property.
 
 Example:
 	g2d at 12800000 {
-- 
1.7.9.5

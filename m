From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 11 Sep 2018 08:00:29 +0530
Subject: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add binding for Rock960
 board
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180911023031.4892-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding for Rock960 board from Vamrs Limited.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index acfd3c773dd0..4b6888a21db2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "vamrs,ficus", "rockchip,rk3399";
 
+- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+    Required root node properties:
+      - compatible = "vamrs,rock960", "rockchip,rk3399";
+
 - Amarula Vyasa RK3288 board
     Required root node properties:
       - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-- 
2.17.1

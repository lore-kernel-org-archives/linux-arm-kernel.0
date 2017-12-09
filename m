From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  9 Dec 2017 01:07:36 +0100
Subject: [PATCH 1/3] dt-bindings: gpu: mali-utgard: add rockchip,
 rk3328-mali compatible
In-Reply-To: <20171209000738.32187-1-heiko@sntech.de>
References: <20171209000738.32187-1-heiko@sntech.de>
Message-ID: <20171209000738.32187-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328 quad-core Cortex A53 uses a Mali-450MP2 with 2 PPs, so
add a compatible for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index c6814d7cc2b2..ad876548ab5d 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -17,6 +17,7 @@ Required properties:
       + rockchip,rk3066-mali
       + rockchip,rk3188-mali
       + rockchip,rk3228-mali
+      + rockchip,rk3328-mali
       + stericsson,db8500-mali
 
   - reg: Physical base address and length of the GPU registers
-- 
2.14.2

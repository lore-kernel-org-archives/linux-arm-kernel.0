From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 10:37:50 +0200
Subject: [PATCH 3/6] dt-bindings: cp110: add sdio clock to cp-110 system
 controller
In-Reply-To: <20170620083754.28053-1-gregory.clement@free-electrons.com>
References: <20170620083754.28053-1-gregory.clement@free-electrons.com>
Message-ID: <20170620083754.28053-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the documentation according to the change made in the
patch "clk: mvebu: cp110: add sdio clock to cp-110 system controller"

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell/cp110-system-controller0.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index e97cc2d73e2e..8caf913c2670 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -34,6 +34,7 @@ The following clocks are available:
    - 0 2	EIP
    - 0 3	Core
    - 0 4	NAND core
+   - 0 5	SDIO core
  - Gatable clocks
    - 1 0	Audio
    - 1 1	Comm Unit
-- 
2.11.0

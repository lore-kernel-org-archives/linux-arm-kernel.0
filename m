From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  1 Jun 2017 16:55:39 +0200
Subject: [PATCH v3 6/9] dt-bindings: cp110: add sdio clock to cp-110 system
 controller
In-Reply-To: <cover.6bb422e6a233460049bb63792b32a5ba851dcddd.1496328934.git-series.gregory.clement@free-electrons.com>
References: <cover.6bb422e6a233460049bb63792b32a5ba851dcddd.1496328934.git-series.gregory.clement@free-electrons.com>
Message-ID: <c4ebada50633c7a14cd2bcfa56ace329204982c8.1496328934.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the documentation according to the change made in the
patch "clk: mvebu: cp110: add sdio clock to cp-110 system controller"

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 1 +
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
git-series 0.9.1

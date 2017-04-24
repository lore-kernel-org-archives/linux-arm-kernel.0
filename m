From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 24 Apr 2017 15:22:03 -0500
Subject: [PATCH v2 3/4] ARM: keystone: Create new binding for K2G ICE evm
In-Reply-To: <20170424202204.24170-1-fcooper@ti.com>
References: <20170424202204.24170-1-fcooper@ti.com>
Message-ID: <20170424202204.24170-4-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new binding for the new K2G Industrial Communication Engine evm.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/keystone/keystone.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
index 48f6703..f310bad 100644
--- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
@@ -37,3 +37,6 @@ Boards:
 
 -  K2G EVM
    compatible = "ti,k2g-evm", "ti,k2g", "ti-keystone"
+
+-  K2G Industrial Communication Engine EVM
+   compatible = "ti,k2g-ice", "ti,k2g", "ti-keystone"
-- 
2.10.0

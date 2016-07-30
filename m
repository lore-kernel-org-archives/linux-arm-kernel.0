From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 29 Jul 2016 17:34:03 -0700
Subject: [PATCH net-next 10/10] Documentation: dtb: xgene: Add rxlos GPIO
 mapping
In-Reply-To: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
References: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
Message-ID: <1469838843-19943-11-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
---
 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
index 05f705e3..b83ae67 100644
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -24,6 +24,7 @@ Required properties for all the ethernet interfaces:
 - clocks: Reference to the clock entry.
 - local-mac-address: MAC address assigned to this device
 - phy-connection-type: Interface type between ethernet device and PHY device
+- rxlos-gpios: rxlos GPIO mapping
 
 Required properties for ethernet interfaces that have external PHY:
 - phy-handle: Reference to a PHY node connected to this device
-- 
1.9.1

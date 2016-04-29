From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 29 Apr 2016 11:10:14 -0700
Subject: [PATCH v2 2/3] Documentation: dtb: xgene: Add channel property
In-Reply-To: <1461953415-9741-1-git-send-email-isubramanian@apm.com>
References: <1461953415-9741-1-git-send-email-isubramanian@apm.com>
Message-ID: <1461953415-9741-3-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
index 078060a..05f705e3 100644
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -18,6 +18,8 @@ Required properties for all the ethernet interfaces:
   - First is the Rx interrupt.  This irq is mandatory.
   - Second is the Tx completion interrupt.
     This is supported only on SGMII based 1GbE and 10GbE interfaces.
+- channel: Ethernet to CPU, start channel (prefetch buffer) number
+  - Must map to the first irq and irqs must be sequential
 - port-id: Port number (0 or 1)
 - clocks: Reference to the clock entry.
 - local-mac-address: MAC address assigned to this device
-- 
1.9.1

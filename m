From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 20 Jul 2016 20:26:12 +0530
Subject: [net-next PATCH 1/3] net: phy: dp83867: Add documentation for
 optional impedance control
In-Reply-To: <20160720145614.13132-1-mugunthanvnm@ti.com>
References: <20160720145614.13132-1-mugunthanvnm@ti.com>
Message-ID: <20160720145614.13132-2-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documention of ti,impedance-control which can be used to
correct MAC impedance mismatch using phy extended registers.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 Documentation/devicetree/bindings/net/ti,dp83867.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
index 5d21141..531ea3c5 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
@@ -9,6 +9,13 @@ Required properties:
 	- ti,fifo-depth - Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h
 		for applicable values
 
+Optional property:
+	- ti,impedance-control - MAC Interface Impedance control to vary the
+				 output impedance with an approximate range
+				 from 35-70 ohms in 32 steps. Value range can
+				 be 0x0 to 0x1f. Lowest impedance value is
+				 0x1f and highest impedance being 0x0.
+
 Default child nodes are standard Ethernet PHY device
 nodes as described in Documentation/devicetree/bindings/net/phy.txt
 
-- 
2.9.2.368.g08bb350

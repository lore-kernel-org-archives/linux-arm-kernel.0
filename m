From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 13:53:16 +1100
Subject: [PATCH v3 1/6] mfd: dt: Fix "indicates" typo in mfd bindings document
In-Reply-To: <20161206025321.1792-1-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
Message-ID: <20161206025321.1792-2-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mfd/mfd.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
index af9d6931a1a2..f1fceeda12f1 100644
--- a/Documentation/devicetree/bindings/mfd/mfd.txt
+++ b/Documentation/devicetree/bindings/mfd/mfd.txt
@@ -19,7 +19,7 @@ Optional properties:
 
 - compatible : "simple-mfd" - this signifies that the operating system should
   consider all subnodes of the MFD device as separate devices akin to how
-  "simple-bus" inidicates when to see subnodes as children for a simple
+  "simple-bus" indicates when to see subnodes as children for a simple
   memory-mapped bus. For more complex devices, when the nexus driver has to
   probe registers to figure out what child devices exist etc, this should not
   be used. In the latter case the child devices will be determined by the
-- 
2.9.3

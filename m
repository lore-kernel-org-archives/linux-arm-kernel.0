From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Mar 2014 16:24:14 +0100
Subject: [PATCH 2/3] DT: Vendors: Add vendor prefix for Macronix
In-Reply-To: <1393773855-9592-1-git-send-email-andrew@lunn.ch>
References: <1393773855-9592-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393773855-9592-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vendor prefix mxicy for Macronix International Co., Ltd.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 860c467374fe..f4599aea1f7d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -62,6 +62,7 @@ maxim	Maxim Integrated Products
 microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 mpl	MPL AG
+mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
 netgear	Netgear, Inc.
 nintendo	Nintendo
-- 
1.8.5.3

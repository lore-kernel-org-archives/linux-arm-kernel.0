From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  5 Mar 2014 22:33:26 +0100
Subject: [RESEND Patch 2/3] DT: Vendors: Add vendor prefix for Macronix
In-Reply-To: <1394055207-4639-1-git-send-email-andrew@lunn.ch>
References: <1394055207-4639-1-git-send-email-andrew@lunn.ch>
Message-ID: <1394055207-4639-3-git-send-email-andrew@lunn.ch>
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
@@ -63,4 +63,5 @@ microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 mpl	MPL AG
+mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
 netgear	Netgear, Inc.
-- 
1.9.0

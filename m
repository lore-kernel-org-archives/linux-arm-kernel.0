From: hao5781286@gmail.com (Hao Zhang)
Date: Sun, 20 Nov 2016 18:45:38 +0800
Subject: [PATCH v4 1/3] Documentation: DT: add dma compatible for sun50i A64
 SOC
In-Reply-To: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
References: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
Message-ID: <1479638740-20520-2-git-send-email-hao5781286@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the property of Allwinner sun50i A64 dma.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 6b26704..4398b99 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -9,6 +9,7 @@ Required properties:
 		  "allwinner,sun8i-a23-dma"
 		  "allwinner,sun8i-a83t-dma"
 		  "allwinner,sun8i-h3-dma"
+		  "allwinner,sun50i-a64-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
-- 
2.7.4

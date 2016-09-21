From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:37 +0200
Subject: [PATCH v2 4/6] misc: sram: document new compatible
In-Reply-To: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160921220939.27924-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add atmel,sama5d2-securam to the compatible list.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sram/sram.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
index add48f09015e..068c2c03c38f 100644
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sram.txt
@@ -4,7 +4,7 @@ Simple IO memory regions to be managed by the genalloc API.
 
 Required properties:
 
-- compatible : mmio-sram
+- compatible : mmio-sram or atmel,sama5d2-securam
 
 - reg : SRAM iomem address range
 
-- 
2.9.3

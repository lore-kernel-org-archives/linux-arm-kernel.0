From: yingjoe.chen@mediatek.com (Joe.C)
Date: Thu, 9 Oct 2014 22:29:39 +0800
Subject: [PATCH v3 6/7] dt-bindings: add irq domain parent binding
In-Reply-To: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1412864980-20273-7-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add "arm,irq-domain-hierarchy" optional property.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/arm/gic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index c7d2fa1..f0bb759 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -68,6 +68,8 @@ Example:
 		      <0xfff10100 0x100>;
 	};
 
+- arm,irq-domain-hierarchy : When this property exists, gic will be used as
+  parent for hierarchy irq domain.
 
 * GIC virtualization extensions (VGIC)
 
-- 
1.8.1.1.dirty

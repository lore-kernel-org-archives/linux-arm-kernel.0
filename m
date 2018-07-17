From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 17 Jul 2018 16:52:23 +0800
Subject: [PATCH v5 02/11] dt-bindings: mediatek: Add smi dts binding for
 Mediatek MT6765 SoC
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1531817552-17221-3-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MT6765 smi binding document

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 .../memory-controllers/mediatek,smi-common.txt     |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index aa614b2..0bf64f5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -15,6 +15,7 @@ not needed for SMI generation 2.
 Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
+	"mediatek,mt6765-smi-common", "syscon"
 	"mediatek,mt8173-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
-- 
1.7.9.5

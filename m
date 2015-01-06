From: howard.chen@linaro.org (Howard Chen)
Date: Tue,  6 Jan 2015 16:42:31 +0800
Subject: [PATCH 2/2] dt-bindings: add mt6592 compatible string for mediatek
 sysirq
In-Reply-To: <1420533751-23999-1-git-send-email-howard.chen@linaro.org>
References: <1420533751-23999-1-git-send-email-howard.chen@linaro.org>
Message-ID: <1420533751-23999-2-git-send-email-howard.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Howard Chen <howard.chen@linaro.org>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
index d680b07..4cd6f7b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: should be one of:
 	"mediatek,mt8135-sysirq"
 	"mediatek,mt8127-sysirq"
+	"mediatek,mt6592-sysirq"
 	"mediatek,mt6589-sysirq"
 	"mediatek,mt6582-sysirq"
 	"mediatek,mt6577-sysirq"
-- 
1.9.1

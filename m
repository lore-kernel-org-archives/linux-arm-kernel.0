From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Dec 2016 15:26:46 +0800
Subject: [PATCH v2 2/3] dt-bindings: zx296718-clk: add compatible for audio
 clock controller
In-Reply-To: <1481873207-22929-1-git-send-email-shawnguo@kernel.org>
References: <1481873207-22929-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1481873207-22929-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds the compatible string for zx296718 audio clock controller.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/zx296718-clk.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/zx296718-clk.txt b/Documentation/devicetree/bindings/clock/zx296718-clk.txt
index 8c18b7b237bf..4ad703808407 100644
--- a/Documentation/devicetree/bindings/clock/zx296718-clk.txt
+++ b/Documentation/devicetree/bindings/clock/zx296718-clk.txt
@@ -13,6 +13,9 @@ Required properties:
 	"zte,zx296718-lsp1crm":
 		zx296718 device level clock selection and gating
 
+	"zte,zx296718-audiocrm":
+		zx296718 audio clock selection, divider and gating
+
 - reg: Address and length of the register set
 
 The clock consumer should specify the desired clock by having the clock
-- 
1.9.1

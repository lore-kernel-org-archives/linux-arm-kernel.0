From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 10 Aug 2018 23:23:38 +0530
Subject: [PATCH 3/4] dt-bindings: arm: hisilicon: Add binding for HiKey970
 board
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180810175339.25421-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding for HiKey970 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 14f54f569c63..a97f643e7d1c 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -12,6 +12,10 @@ Hi3670 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3670";
 
+HiKey970 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
+
 Hi3798cv200 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3798cv200";
-- 
2.17.1

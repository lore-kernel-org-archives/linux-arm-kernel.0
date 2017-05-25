From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 25 May 2017 16:18:43 +0800
Subject: [PATCH v2 01/12] dt-bindings: arm: hisilicon: add bindings for
 HiKey960 board
In-Reply-To: <20170525081854.4701-1-guodong.xu@linaro.org>
References: <20170525081854.4701-1-guodong.xu@linaro.org>
Message-ID: <20170525081854.4701-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for HiKey960 Board.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 2e73215..7111fbc8 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -4,6 +4,10 @@ Hi3660 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3660";
 
+HiKey960 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
+
 Hi3798cv200 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3798cv200";
-- 
2.10.2

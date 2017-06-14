From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:18 +0800
Subject: [PATCH v3 01/21] dt-bindings: arm: hisilicon: add bindings for
 HiKey960 board
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-2-guodong.xu@linaro.org>
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

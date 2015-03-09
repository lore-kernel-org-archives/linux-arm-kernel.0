From: tyler.baker@linaro.org (tyler.baker at linaro.org)
Date: Mon,  9 Mar 2015 13:19:58 -0700
Subject: [PATCH v2 2/2] ARM: dts: add vendor prefix for cubietech
In-Reply-To: <1425932398-7194-1-git-send-email-tyler.baker@linaro.org>
References: <1425932398-7194-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1425932398-7194-3-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler.baker@linaro.org>

Add a cubietech vendor prefix, as it is missing. The cubietruck, cubieboard2,
and cubieboard all already reference this prefix.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index aeb5bb5..58364cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -45,6 +45,7 @@ cnxt	Conexant Systems, Inc.
 cortina	Cortina Systems, Inc.
 cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
+cubietech	Cubietech, Ltd.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
 denx	Denx Software Engineering
-- 
2.1.0

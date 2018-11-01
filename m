From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu,  1 Nov 2018 21:00:41 +0100
Subject: [PATCH v2 3/7] dt-bindings: Add vendor prefix for LeMaker
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
Message-ID: <20181101200045.6078-4-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a new device-tree binding vendor prefix for Shenzhen
LeMaker Technology Co., Ltd.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0f5453d1823c..4eecfbf866a4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -206,6 +206,7 @@ laird	Laird PLC
 lantiq	Lantiq Semiconductor
 lattice	Lattice Semiconductor
 lego	LEGO Systems A/S
+lemaker	Shenzhen LeMaker Technology Co., Ltd.
 lenovo	Lenovo Group Ltd.
 lg	LG Corporation
 libretech	Shenzhen Libre Technology Co., Ltd
-- 
2.19.1

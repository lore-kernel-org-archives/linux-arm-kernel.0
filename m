From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  1 Nov 2016 10:36:32 -0500
Subject: [PATCH 3/3] dt-bindings: Add vendor prefix for Samtec
In-Reply-To: <20161101153632.6844-1-dinguyen@kernel.org>
References: <20161101153632.6844-1-dinguyen@kernel.org>
Message-ID: <20161101153632.6844-3-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a vendor prefix for Samtec, a Softing company.

http://www.samtec.de
http://www.samtec.org

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 948d3ac..bff8f53 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -232,6 +232,7 @@ richtek	Richtek Technology Corporation
 ricoh	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
+samtec	Samtec/Softing company
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
-- 
2.8.3

From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 10 May 2017 12:31:03 +0000
Subject: [PATCH 2/2] devicetree: add Roofull vendor prefix
In-Reply-To: <20170510123103.21992-1-codekipper@gmail.com>
References: <20170510123103.21992-1-codekipper@gmail.com>
Message-ID: <20170510123103.21992-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the "roofull" vendor prefix for Shenzhen Roofull Technology Co, Ltd.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 832759934517..4c16c63d7108 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -269,6 +269,7 @@ ricoh	Ricoh Co. Ltd.
 rikomagic	Rikomagic Tech Corp. Ltd
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 rohm	ROHM Semiconductor Co., Ltd
+roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
 sandisk	Sandisk Corporation
-- 
2.12.2

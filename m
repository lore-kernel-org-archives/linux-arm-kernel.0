From: lukma@denx.de (Lukasz Majewski)
Date: Tue,  3 Jan 2017 11:46:20 +0100
Subject: [PATCH v3 1/2] Doc: devicetree: bindings: Add vendor prefix entry -
 lwn
Message-ID: <1483440381-24268-1-git-send-email-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds entry for LWN - the Liebherr-Werk Nenzing GmbH company to
vendor-prefixes.txt file.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v3:
- Update to v4.10-rc2

Changes for v2:
- New patch
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e..8e2abcb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -164,6 +164,7 @@ lg	LG Corporation
 linux	Linux-specific binding
 lltc	Linear Technology Corporation
 lsi	LSI Corp. (LSI Logic)
+lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
-- 
2.1.4

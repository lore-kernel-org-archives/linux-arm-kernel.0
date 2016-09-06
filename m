From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 16:46:16 +0200
Subject: [PATCH v2 5/9] of: Add vendor prefix for Netron DY
In-Reply-To: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906144620.6322-6-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Netron DY is a brand of LCD panels found on SBCs and tablets.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa97d45a..9c1ab3c1132b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -176,6 +176,7 @@ nec	NEC LCD Technologies, Ltd.
 neonode		Neonode Inc.
 netgear	NETGEAR
 netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
+netron-dy	Netron DY
 netxeon		Shenzhen Netxeon Technology CO., LTD
 newhaven	Newhaven Display International
 nintendo	Nintendo
-- 
2.9.3

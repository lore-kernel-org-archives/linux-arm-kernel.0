From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 05:01:51 +0200
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for MeLE
In-Reply-To: <20171016030153.11078-1-afaerber@suse.de>
References: <20171016030153.11078-1-afaerber@suse.de>
Message-ID: <20171016030153.11078-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MeLE is a Chinese manufacturer of TV boxes and Mini PCs.

Cc: meleservice at mele.cn
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index dbbde903682b..bc7f7b4618b4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -199,6 +199,7 @@ mcube	mCube
 meas	Measurement Specialties
 mediatek	MediaTek Inc.
 megachips	MegaChips
+mele	Shenzhen MeLE Digital Technology Ltd.
 melexis	Melexis N.V.
 melfas	MELFAS Inc.
 mellanox	Mellanox Technologies
-- 
2.13.6

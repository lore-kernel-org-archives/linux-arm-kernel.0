From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  4 Mar 2017 22:51:24 +0100
Subject: [PATCH 1/3] devicetree: add vendor prefix for Khadas
In-Reply-To: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170304215126.7020-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Khadas is a new sub-brand of Shenzhen Wesion Technology CO.,LTD. They
are developing Amlogic and Rockchip based "DIY boxes" (single board
computers): http://khadas.com/
They are best know for their latest product: the Khadas VIM (an Amlogic
GXL S905X based SBC).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 9946aedcf146..65e5d077f97b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -155,6 +155,7 @@ jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
 keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
+khadas	Khadas
 kinetic Kinetic Technologies
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
-- 
2.12.0

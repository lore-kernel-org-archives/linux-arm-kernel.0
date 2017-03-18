From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 13:36:55 +0100
Subject: [PATCH v2 1/3] devicetree: add vendor prefix for Khadas
In-Reply-To: <20170318123657.13798-1-martin.blumenstingl@googlemail.com>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
 <20170318123657.13798-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170318123657.13798-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Khadas is a new sub-brand of "Shenzhen Wesion Technology Co., Ltd.".
They are developing Amlogic and Rockchip based "DIY boxes" (single board
computers): http://khadas.com/
They are best know for their latest product: the Khadas VIM (an Amlogic
GXL S905X based SBC).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index da05060803b2..4dcc3a7bcf2d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -160,6 +160,7 @@ jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
 keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
+khadas	Khadas
 kinetic Kinetic Technologies
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
-- 
2.12.0

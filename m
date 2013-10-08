From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue,  8 Oct 2013 14:56:40 +0200
Subject: [PATCH] Documentation: add moxa vendor prefix
Message-ID: <1381237000-8398-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add moxa vendor prefix.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Submitting this per Mark Rutland's request.
    
    Applies to next-20130927

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2956800..0a04e89 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -40,6 +40,7 @@ marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
+moxa	Moxa Technology Co., Ltd.
 national	National Semiconductor
 nintendo	Nintendo
 nvidia	NVIDIA
-- 
1.8.2.1

From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 25 Jun 2014 11:59:30 +0530
Subject: [PATCH 1/4 v2] devicetree: bindings: Document murata vendor prefix
In-Reply-To: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1403677773-21141-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Murata Manufacturing Co., Ltd. to the list of device tree
vendor prefixes.

Murata manufactures NTC (Negative Temperature Coefficient) based
Thermistors for small scale applications like Mobiles and PDAs.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
1. Rearranged vendor-prefix alphabetically
2. Added Acked-by from Mark Rutland

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4d7f375..46a311e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -83,6 +83,7 @@ mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
 mundoreader	Mundo Reader S.L.
+murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
 neonode		Neonode Inc.
-- 
1.7.9.5

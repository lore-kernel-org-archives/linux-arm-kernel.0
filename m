From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 26 Aug 2017 12:21:42 +0530
Subject: [PATCH 1/2] of: Add vendor prefix for Amarula Solutions
Message-ID: <1503730303-11422-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Added 'amarula' as a vendor prefix for Amarula Solutions,
specialist in Embedded and Opensource solutions.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7e5754e..2e9cd5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -17,6 +17,7 @@ al	Annapurna Labs
 allwinner	Allwinner Technology Co., Ltd.
 alphascale	AlphaScale Integrated Circuits Systems, Inc.
 altr	Altera Corp.
+amarula	Amarula Solutions
 amazon	Amazon.com, Inc.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
-- 
2.7.4

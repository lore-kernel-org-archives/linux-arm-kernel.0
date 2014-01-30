From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 29 Jan 2014 22:36:38 -0300
Subject: [PATCH] of: add vendor prefix for Allwinner Technology
Message-ID: <1391045798-7053-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have been using the "allwinner" prefix for everything so far; let's
document it here.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index edbb8d8..5a2904b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -7,6 +7,7 @@ ad	Avionic Design GmbH
 adi	Analog Devices, Inc.
 aeroflexgaisler	Aeroflex Gaisler AB
 ak	Asahi Kasei Corp.
+allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 apm	Applied Micro Circuits Corporation (APM)
-- 
1.8.5.3

From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 12:40:20 +0200
Subject: [PATCH v8 9/9] add Alphascale to vendor-prefixes.txt
In-Reply-To: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1413888020-8790-10-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this company already provided some products, so it make sense to add
them to vendor-prefixes.txt list

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..23c862f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -11,6 +11,7 @@ adi	Analog Devices, Inc.
 aeroflexgaisler	Aeroflex Gaisler AB
 ak	Asahi Kasei Corp.
 allwinner	Allwinner Technology Co., Ltd.
+alphascale	AlphaScale Integrated Circuits Systems, Inc.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
-- 
1.9.1

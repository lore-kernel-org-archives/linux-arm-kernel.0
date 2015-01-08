From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu,  8 Jan 2015 10:16:47 +0100
Subject: [PATCH 3/3] add Alphascale to vendor-prefixes.txt
In-Reply-To: <1420708607-23052-1-git-send-email-linux@rempel-privat.de>
References: <1733388.SP14pjVoMj@wuerfel>
 <1420708607-23052-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1420708607-23052-4-git-send-email-linux@rempel-privat.de>
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
index 0d35462..c03fc80 100644
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

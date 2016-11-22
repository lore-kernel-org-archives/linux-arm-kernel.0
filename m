From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 22 Nov 2016 21:59:07 +0100
Subject: [PATCH v3 1/2] devicetree: Add vendor prefix for CZ.NIC
Message-ID: <20161122205908.7297-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
Acked-by: Rob Herring <robh@kernel.org>
---
changes since v2:
 - add ack by Rob Herring

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f0a48ea78659..ae9fce9fed03 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -67,6 +67,7 @@ creative	Creative Technology Ltd
 crystalfontz	Crystalfontz America, Inc.
 cubietech	Cubietech, Ltd.
 cypress	Cypress Semiconductor Corporation
+cznic	CZ.NIC, z.s.p.o.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
 delta	Delta Electronics, Inc.
-- 
2.10.2

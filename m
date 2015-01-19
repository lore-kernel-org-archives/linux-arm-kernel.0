From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 20 Jan 2015 00:22:57 +0100
Subject: [PATCH 1/3] of: Add vendor prefix for MINIX
In-Reply-To: <1421709779-25691-1-git-send-email-b.galvani@gmail.com>
References: <1421709779-25691-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1421709779-25691-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MINIX Technology Limited to the list of device tree vendor
prefixes. The company manufactures digital media players and mini-ITX
motherboards.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..09b01de 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -100,6 +100,7 @@ merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 micron	Micron Technology Inc.
+minix	MINIX Technology Ltd.
 mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
-- 
2.1.4

From: manu@freebsd.org (Emmanuel Vadot)
Date: Tue, 24 Jul 2018 12:15:21 +0200
Subject: [PATCH v2 4/5] nvmem: sunxi-sid: add support for H5's SID controller
In-Reply-To: <20180724101522.68165-1-manu@freebsd.org>
References: <20180724101522.68165-1-manu@freebsd.org>
Message-ID: <20180724101522.68165-4-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H5 SoC have a SID controller that looks like the one in A64, but
in case we find some difference in the futur at a binding for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index e319fe5e205a..99c4ba6a3f61 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -7,6 +7,7 @@ Required properties:
   "allwinner,sun8i-a83t-sid"
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
+  "allwinner,sun50i-h5-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.17.0

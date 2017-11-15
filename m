From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 15 Nov 2017 22:37:53 +0100
Subject: [PATCH v4 1/5] dt-bindings: vendor prefix for Wi2Wi, Inc.
In-Reply-To: <cover.1510781875.git.hns@goldelico.com>
References: <cover.1510781875.git.hns@goldelico.com>
Message-ID: <624f3e20e243a4edde051ce03284c66b0679bcce.1510781876.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce vendor prefix for Wi2Wi, Inc. for W2SG00x4 GPS modules
and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1afd298eddd7..ad4381738954 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -366,6 +366,7 @@ voipac	Voipac Technologies s.r.o.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
 wlf	Wolfson Microelectronics
-- 
2.12.2

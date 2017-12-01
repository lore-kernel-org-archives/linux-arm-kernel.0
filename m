From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri,  1 Dec 2017 08:49:34 +0100
Subject: [PATCH v5 1/5] dt-bindings: define vendor prefix for Wi2Wi, Inc.
In-Reply-To: <cover.1512114576.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
Message-ID: <876647948fceb763a0b584b70c3805dec562072e.1512114576.git.hns@goldelico.com>
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
index 0994bdd82cd3..879f1d9291cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -382,6 +382,7 @@ voipac	Voipac Technologies s.r.o.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
 wlf	Wolfson Microelectronics
-- 
2.12.2

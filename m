From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 15 Nov 2017 16:19:09 +0100
Subject: [PATCH v3 1/5] DT: vendor prefix for Wi2Wi, Inc.
In-Reply-To: <cover.1510759152.git.hns@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
Message-ID: <6b698f73266d80a5efc8ddcd33e30f1c33bac2ca.1510759152.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce vendor prefix for Wi2Wi, Inc. for W2SG00x4 GPS modules
and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
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

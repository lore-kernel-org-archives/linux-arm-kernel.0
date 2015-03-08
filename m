From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Sun,  8 Mar 2015 14:58:16 +0300
Subject: [PATCH v2 2/2] dt-bindings: Add vendor-prefix for Wexler
In-Reply-To: <1425456947-4152-1-git-send-email-mamlinav@gmail.com>
References: <1425456947-4152-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1425815896-5798-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds vendor-prefix for Wexler.

WEXLER trademark owned by AVIRSA Electronics, a member of the
diversified holding AVIRSA.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
Changes since v1:
* Change vendor name. Wexler is more known than AVIRSA.

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389ca13..eb67da4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -189,6 +189,7 @@ variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
 voipac	Voipac Technologies s.r.o.
+wexler	Wexler
 winbond Winbond Electronics corp.
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
-- 
2.0.5

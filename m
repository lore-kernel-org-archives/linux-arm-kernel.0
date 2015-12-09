From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  9 Dec 2015 12:48:14 +0100
Subject: [PATCH v2 01/14] devicetree: add vendor prefix for Vivante Corporation
Message-ID: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <philipp.zabel@gmail.com>

Trivial patch to add Vivante Corporation to the list of
devicetree vendor prefixes.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d444e9f..c2767a772650 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -238,6 +238,7 @@ v3	V3 Semiconductor
 variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
+vivante	Vivante Corporation
 voipac	Voipac Technologies s.r.o.
 wexler	Wexler
 winbond Winbond Electronics corp.
-- 
2.6.2

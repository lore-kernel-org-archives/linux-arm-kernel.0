From: darshanapadmadas@gmail.com (Darshana Padmadas)
Date: Tue,  7 Oct 2014 17:15:06 +0530
Subject: [PATCH v3 2/4] Documentation: devicetree: bindings: Document
 deprecated device vendor name to fix related warning
In-Reply-To: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <1412682308-8784-3-git-send-email-darshanapadmadas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents deprecated vendor name of device isl29028 for compatibility with older kernels.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..e2503b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,6 +68,7 @@ img	Imagination Technologies Ltd.
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
+isil 	Intersil (deprecated, use isl)
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
-- 
1.9.1

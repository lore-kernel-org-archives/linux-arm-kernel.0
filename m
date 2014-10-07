From: darshanapadmadas@gmail.com (Darshana Padmadas)
Date: Tue,  7 Oct 2014 20:49:27 +0530
Subject: [PATCH v4 2/4] Documentation: devicetree: bindings: Document
 deprecated device vendor name to fix related warning
In-Reply-To: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <1412695169-22815-3-git-send-email-darshanapadmadas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents deprecated vendor name of device isl29028 for compatibility with older kernels.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..ab97459 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,6 +68,7 @@ img	Imagination Technologies Ltd.
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
+isil    Intersil (deprecated, use isl)
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
-- 
1.9.1

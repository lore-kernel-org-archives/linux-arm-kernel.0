From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 7 Nov 2013 19:11:41 +0900
Subject: [PATCH v10 2/7] of: add vendor prefix for Trusted Logic Mobility
In-Reply-To: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1383819106-1400-3-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "tlm" prefix for Trusted Logic Mobility.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2956800f0240..d4d42aa9f2fa 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -66,6 +66,7 @@ ste	ST-Ericsson
 stericsson	ST-Ericsson
 toumaz	Toumaz
 ti	Texas Instruments
+tlm	Trusted Logic Mobility
 toshiba	Toshiba Corporation
 v3	V3 Semiconductor
 via	VIA Technologies, Inc.
-- 
1.8.4.2

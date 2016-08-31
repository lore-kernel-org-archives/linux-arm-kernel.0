From: ayaka@soulik.info (Randy Li)
Date: Wed, 31 Aug 2016 21:00:25 +0800
Subject: [PATCH 3/3 v3] devicetree: bindings: Add vendor prefix for Topeet.
In-Reply-To: <f90ffaf4-dc95-9c32-1f4d-771f96424783@kernel.org>
References: <f90ffaf4-dc95-9c32-1f4d-771f96424783@kernel.org>
Message-ID: <1472648425-3920-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TOPEET, a ARM devlopment board vendor in China mainland.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0d9d4d8..1e28cfd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -266,6 +266,7 @@ technologic	Technologic Systems
 thine	THine Electronics, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
+topeet  Topeet
 toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
-- 
2.7.4

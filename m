From: ayaka@soulik.info (Randy Li)
Date: Sun, 18 Sep 2016 22:01:19 +0800
Subject: [PATCH v7 3/3] devicetree: bindings: Add vendor prefix for Topeet.
In-Reply-To: <1474207279-9662-1-git-send-email-ayaka@soulik.info>
References: <1474207279-9662-1-git-send-email-ayaka@soulik.info>
Message-ID: <1474207279-9662-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TOPEET, a ARM devlopment board vendor in China mainland.

Signed-off-by: Randy Li <ayaka@soulik.info>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 69caf14..cfbf217 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -271,6 +271,7 @@ technologic	Technologic Systems
 thine	THine Electronics, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
+topeet  Topeet
 toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
-- 
2.7.4

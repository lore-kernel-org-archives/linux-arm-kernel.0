From: ayaka@soulik.info (Randy Li)
Date: Thu,  8 Sep 2016 05:58:55 +0800
Subject: [PATCH v6 3/3] devicetree: bindings: Add vendor prefix for Topeet.
In-Reply-To: <1473285535-21996-1-git-send-email-ayaka@soulik.info>
References: <1473285535-21996-1-git-send-email-ayaka@soulik.info>
Message-ID: <1473285535-21996-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TOPEET, a ARM devlopment board vendor in China mainland.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7958a60..fa64536 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -269,6 +269,7 @@ technologic	Technologic Systems
 thine	THine Electronics, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
+topeet  Topeet
 toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
-- 
2.7.4

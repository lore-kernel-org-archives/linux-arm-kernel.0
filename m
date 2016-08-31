From: ayaka@soulik.info (Randy Li)
Date: Thu,  1 Sep 2016 06:06:52 +0800
Subject: [PATCH v5 3/3] devicetree: bindings: Add vendor prefix for Topeet.
In-Reply-To: <1472681212-5287-1-git-send-email-ayaka@soulik.info>
References: <1472681212-5287-1-git-send-email-ayaka@soulik.info>
Message-ID: <1472681212-5287-4-git-send-email-ayaka@soulik.info>
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

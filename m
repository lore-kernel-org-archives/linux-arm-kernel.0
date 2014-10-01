From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed,  1 Oct 2014 23:29:44 +0200
Subject: [PATCH 4/6] of: add vendor prefix for Tronsmart
In-Reply-To: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412198986-26534-5-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Tronsmart to the list of device tree vendor prefixes.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c681434..92a1798 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -141,6 +141,7 @@ tlm	Trusted Logic Mobility
 toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
+tronsmart	Tronsmart
 usi	Universal Scientifc Industrial Co., Ltd.
 v3	V3 Semiconductor
 variscite	Variscite Ltd.
-- 
1.9.1

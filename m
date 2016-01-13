From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 13 Jan 2016 12:45:11 -0800
Subject: [PATCH 1/2] of: add vendor prefix for UniWest
Message-ID: <b11bf2208fe30b96c4d82e634e8abe04343754de.1452717014.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

United Western Technologies Corp, known primarily as UniWest,
is a manufacturer of eddy current and ultrasonic testing equipment.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..7dabdee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -230,6 +230,7 @@ toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
 tplink	TP-LINK Technologies Co., Ltd.
+uniwest	United Western Technologies Corp (UniWest)
 tronfy	Tronfy
 truly	Truly Semiconductors Limited
 upisemi	uPI Semiconductor Corp.
-- 
2.5.0

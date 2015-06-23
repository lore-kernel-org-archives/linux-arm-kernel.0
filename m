From: merker@debian.org (Karsten Merker)
Date: Tue, 23 Jun 2015 19:02:29 +0200
Subject: [PATCH V4 2/2] devicetree: Add msi to the vendor-prefix list
In-Reply-To: <1435078949-3383-1-git-send-email-merker@debian.org>
References: <20150618115838.GL11732@lukather>
 <1435078949-3383-1-git-send-email-merker@debian.org>
Message-ID: <1435078949-3383-3-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the the "msi" (Micro-Star International Co. Ltd.) vendor prefix
which is used in sun6i-a31s-primo81.dts.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6a99dda..c415c2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -127,6 +127,7 @@ mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+msi	Micro-Star International Co. Ltd.
 mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
 mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
-- 
2.1.4

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 22:08:46 +0200
Subject: [PATCH v2 1/5] devicetree: vendor-prefixes: Add CompuLab to known
 vendors
In-Reply-To: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430770130-7833-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds "compulab" as a vendor-prefix for CompuLab (compulab.co.il),
an Israeli company that builds ARM-based SoMs and CoMs.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 80339192c93e..ff94ac484887 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -49,6 +49,7 @@ cirrus	Cirrus Logic, Inc.
 cloudengines	Cloud Engines, Inc.
 cnm	Chips&Media, Inc.
 cnxt	Conexant Systems, Inc.
+compulab	CompuLab
 cortina	Cortina Systems, Inc.
 cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
-- 
2.1.0

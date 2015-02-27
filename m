From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 27 Feb 2015 13:24:43 +0100
Subject: [PATCH v2 2/4] devicetree: vendor-prefixes: Add CompuLab to known
 vendors
In-Reply-To: <1425039885-5137-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425039885-5137-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1425039885-5137-3-git-send-email-sebastian.hesselbarth@gmail.com>
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
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389ca1347a77..03d139c1174b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -42,6 +42,7 @@ cirrus	Cirrus Logic, Inc.
 cloudengines	Cloud Engines, Inc.
 cnm	Chips&Media, Inc.
 cnxt	Conexant Systems, Inc.
+compulab	CompuLab
 cortina	Cortina Systems, Inc.
 cosmic	Cosmic Circuits
 crystalfontz	Crystalfontz America, Inc.
-- 
2.1.0

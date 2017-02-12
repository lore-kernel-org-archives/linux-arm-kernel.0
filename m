From: carlo@caione.org (Carlo Caione)
Date: Sun, 12 Feb 2017 20:32:46 +0100
Subject: [PATCH 1/2] devicetree: Add vendor prefix for Hwacom Systems Inc.
In-Reply-To: <20170212193247.22705-1-carlo@caione.org>
References: <20170212193247.22705-1-carlo@caione.org>
Message-ID: <20170212193247.22705-2-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Hwacom Systems Inc. is a broadband system integrator and supplier of
mobile, fixed and IP networks related services as well as
multimedia application. Website: http://www.hwacom.com/

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e..a1704a6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -131,6 +131,7 @@ holt	Holt Integrated Circuits, Inc.
 honeywell	Honeywell
 hp	Hewlett Packard
 holtek	Holtek Semiconductor, Inc.
+hwacom	HwaCom Systems Inc.
 i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
-- 
2.9.3

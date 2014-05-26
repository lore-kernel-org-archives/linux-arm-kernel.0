From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 26 May 2014 23:33:28 +0200
Subject: [PATCH 1/2] dt-binding: add vendor prefix for SolidRun
Message-ID: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SolidRun is a company from Israel producing small-sized home-media
computers like the Marvell Dove based CuBox and Freescale IMX based
CuBox-i. Document the missing vendor prefix.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0f01c9bf19c8..f0c046aff55b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -102,6 +102,7 @@ sii	Seiko Instruments, Inc.
 sirf	SiRF Technology, Inc.
 smsc	Standard Microsystems Corporation
 snps 	Synopsys, Inc.
+solidrun	SolidRun
 spansion	Spansion Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
-- 
1.9.1

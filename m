From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 21 Jan 2014 19:30:51 -0800
Subject: [PATCH v5 7/8] ARM: brcmstb: gic: add compatible string for Broadcom
 Brahma15
In-Reply-To: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
References: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1390361452-3124-8-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the Broadcom Brahma B15 GIC implementation as compatible
with the ARM GIC standard.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 3dfb0c0..d7409fd 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -15,6 +15,7 @@ Main node required properties:
 	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
+	"brcm,brahma-b15-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
-- 
1.7.1

From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 1 Mar 2016 10:38:18 -0600
Subject: [PATCH 2/5] Documentation: dt: socfpga: Add Altera Arri10 L2 cache
 binding
In-Reply-To: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
References: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1456850301-22066-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree binding string needed to support the Altera L2
cache on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 885f93d..4cea386 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -13,7 +13,8 @@ Subcomponents:
 
 L2 Cache ECC
 Required Properties:
-- compatible : Should be "altr,socfpga-l2-ecc"
+- compatible : Should be "altr,socfpga-l2-ecc" or
+	       "altr,socfpga-a10-l2-ecc"
 - reg : Address and size for ECC error interrupt clear registers.
 - interrupts : Should be single bit error interrupt, then double bit error
 	interrupt. Note the rising edge type.
-- 
1.7.9.5

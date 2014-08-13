From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Aug 2014 16:29:30 -0700
Subject: [PATCH 2/3] ARM: l2c: order optional properties in alphabetical order
In-Reply-To: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
References: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1407972571-8986-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-order the Level 2 cache controller binding optional properties into
alphabetical order.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/l2cc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index af527ee111c2..b265ef25e55d 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -43,9 +43,9 @@ Optional properties:
 - arm,io-coherent : indicates that the system is operating in an hardware
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
-- interrupts : 1 combined interrupt.
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
+- interrupts : 1 combined interrupt.
 - wt-override: If present then L2 is forced to Write through mode
 
 Example:
-- 
1.9.1

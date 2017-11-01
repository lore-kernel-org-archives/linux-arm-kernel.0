From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  1 Nov 2017 16:20:05 -0700
Subject: [PATCH 1/2] dt-bindings: rng: Document BCM7278 RNG200 compatible
In-Reply-To: <20171101232006.3943-1-f.fainelli@gmail.com>
References: <20171101232006.3943-1-f.fainelli@gmail.com>
Message-ID: <20171101232006.3943-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM7278 includes a RGN200 hardware random number generator, document the
compatible string for that version of the IP.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
index e25a456664b9..0014da9145af 100644
--- a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
+++ b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
@@ -1,7 +1,9 @@
 HWRNG support for the iproc-rng200 driver
 
 Required properties:
-- compatible : "brcm,iproc-rng200"
+- compatible : Must be one of:
+	       "brcm,bcm7278-rng200"
+	       "brcm,iproc-rng200"
 - reg : base address and size of control register block
 
 Example:
-- 
2.9.3

From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon,  7 Aug 2017 00:32:09 +0200
Subject: [PATCH 1/3] dt-bindings: arm: add SMP enable-method for BCM2836
In-Reply-To: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1502058731-12462-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a compatible string "brcm,bcm2836-smp" for Broadcom's
BCM2836 and BCM2837 to the 32 bit ARM CPU device tree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a44253c..b92f12b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -200,6 +200,7 @@ described below.
 			    "arm,realview-smp"
 			    "brcm,bcm11351-cpu-method"
 			    "brcm,bcm23550"
+			    "brcm,bcm2836-smp"
 			    "brcm,bcm-nsp-smp"
 			    "brcm,brahma-b15"
 			    "marvell,armada-375-smp"
-- 
2.7.4

From: rjui@broadcom.com (Ray Jui)
Date: Fri, 18 Sep 2015 14:24:08 -0700
Subject: [PATCH v2 3/9] ARM: dts: Remove unused PCI I/O resource in Cygnus
In-Reply-To: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442611454-16331-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused PCI I/O resource in bcm-cygnus.dtsi

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 30903ba..0a5898b 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -145,8 +145,7 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+		ranges = <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
 		status = "disabled";
 	};
@@ -166,8 +165,7 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+		ranges = <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 		status = "disabled";
 	};
-- 
1.9.1

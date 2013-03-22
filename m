From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:23:36 +0100
Subject: [PATCH 4/4] ARM: at91: remove partial parameter in bootargs for
 at91sam9x5ek.dtsi
In-Reply-To: <cover.1363960549.git.nicolas.ferre@atmel.com>
References: <cover.1363960549.git.nicolas.ferre@atmel.com>
Message-ID: <5a15207e14a48d92754a4bce9a5ef6117b493f6d.1363960549.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the malformed "mem=" bootargs parameter in at91sam9x5ek.dtsi

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # 3.8+
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index f7841f6..a0b4ff9 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -13,7 +13,7 @@
 	compatible = "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "128M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
+		bootargs = "console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs";
 	};
 
 	ahb {
-- 
1.8.0

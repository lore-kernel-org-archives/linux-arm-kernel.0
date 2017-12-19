From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:23 -0600
Subject: [PATCH 5/8] ARM: dts: dra7-evm: Add cpu0 vdd supply
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-6-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vdd-supply as smps123_reg for cpu0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index ef9c90daa74b..a7385c338ee9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -361,7 +361,7 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&smps123_reg>;
+	vdd-supply = <&smps123_reg>;
 };
 
 &omap_dwc3_2 {
-- 
2.15.1

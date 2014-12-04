From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 09:24:39 -0600
Subject: [PATCH] ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply
Message-ID: <1417706679-22294-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Gerlach <d-gerlach@ti.com>

Hook dcdc2 as the cpu0-supply.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 87aa4f3..f7f77a7 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -611,3 +611,7 @@
 &wdt {
 	status = "okay";
 };
+
+&cpu {
+	cpu0-supply = <&dcdc2>;
+};
-- 
2.1.0.GIT

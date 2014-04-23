From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 23 Apr 2014 14:32:52 +0530
Subject: [PATCH v2 1/4] ARM: dts: dra7-evm: Remove the wrong and undocumented
 compatible
In-Reply-To: <1398243775-4145-1-git-send-email-rnayak@ti.com>
References: <1398243775-4145-1-git-send-email-rnayak@ti.com>
Message-ID: <1398243775-4145-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ti,dra752" is neither documented nor correct, since the device is actually a
dra742 device as rightly documented in dt bindings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/dra7-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..7807429 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI DRA7";
-	compatible = "ti,dra7-evm", "ti,dra752", "ti,dra7";
+	compatible = "ti,dra7-evm", "ti,dra7";
 
 	memory {
 		device_type = "memory";
-- 
1.7.9.5

From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:26 -0600
Subject: [PATCH 8/8] ARM: dts: am572x-idk: Add cpu0 vdd supply
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-9-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vdd-supply as smps12_reg for cpu0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index a578fe97ba3b..d0daf48346ab 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -127,3 +127,7 @@
 		status = "okay";
 	};
 };
+
+&cpu0 {
+	vdd-supply = <&smps12_reg>;
+};
-- 
2.15.1

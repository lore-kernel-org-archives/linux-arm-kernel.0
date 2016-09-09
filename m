From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  9 Sep 2016 10:01:09 -0400
Subject: [PATCH 8/8] ARM: dts: rockchip: Add missing unit name to memory nodes
 in rk3xxx boards
In-Reply-To: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
References: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473429669-6185-9-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index bc674ee206ec..c0d8b5446ba7 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -49,7 +49,7 @@
 	model = "bq Curie 2";
 	compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index a2b763e949b4..0a54c4beff8d 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -47,7 +47,7 @@
 	model = "MarsBoard RK3066";
 	compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 6e7f2187a0e3..82465b644443 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -48,7 +48,7 @@
 	model = "Rayeager PX2";
 	compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 1da46d138029..5e8a235ed02d 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -48,7 +48,7 @@
 	model = "Radxa Rock";
 	compatible = "radxa,rock", "rockchip,rk3188";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
 	};
-- 
2.7.4

From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:56 +0000
Subject: [PATCH 02/10] ARM: dts: atlas7: add performance monitor unit node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ye He <Ye.He@csr.com>

Signed-off-by: Ye He <ye.he@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index d590b82..3caa2cc 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -53,6 +53,11 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 29 4>, <0 82 4>;
+	};
+
 	noc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1

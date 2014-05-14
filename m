From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 14 May 2014 15:30:54 -0700
Subject: [RFC PATCH 4/5] ARM: zynq: dt: Use properly rounded frequencies in
 OPPs
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1400106655-22465-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some issues in regards to rounding and different frequency resolution in
the cpufreq and common clock frameworks have been resolved and allow
specifying Zynq's OPPs with properly rounded values.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index c1176abc34d9..06de3068ab21 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -28,8 +28,8 @@
 			operating-points = <
 				/* kHz    uV */
 				666667  1000000
-				333334  1000000
-				222223  1000000
+				333333  1000000
+				222222  1000000
 			>;
 		};
 
-- 
1.9.3.1.ga73a6ad

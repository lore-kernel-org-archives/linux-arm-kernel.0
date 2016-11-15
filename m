From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 15 Nov 2016 15:07:26 +0100
Subject: [PATCH 1/2] ARM: zynq: Remove skeleton.dtsi
Message-ID: <2d42e25d7dd03e562e12e71fd037837737115940.1479218844.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on
"ARM: dts: explicitly mark skeleton.dtsi as deprecated"
(sha1: 9c0da3cc61f1233c2782e2d3d91e3d0707dd4ba5)
skeleton.dtsi is deprecated.
Move address and size-cells directly to zynq-7000.dtsi.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index f283ff08381c..f47a6c1cc752 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -10,9 +10,10 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/include/ "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	compatible = "xlnx,zynq-7000";
 
 	cpus {
-- 
1.9.1

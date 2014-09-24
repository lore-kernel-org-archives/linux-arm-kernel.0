From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 Sep 2014 16:01:33 +0200
Subject: [PATCH 2/2] ARM: zynq: DT: Add missing reference for memory-controller
In-Reply-To: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
References: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
Message-ID: <ca95da888c9cd61e5b5e437b0e1b5cea893455ae.1411567289.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing reference for memory-controller.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index fc90f47f9c03..2690e6d01f71 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -145,7 +145,7 @@
 			cache-level = <2>;
 		};

-		memory-controller at f8006000 {
+		mc: memory-controller at f8006000 {
 			compatible = "xlnx,zynq-ddrc-a05";
 			reg = <0xf8006000 0x1000>;
 		} ;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/c16a8e15/attachment-0001.sig>

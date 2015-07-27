From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:13 +0200
Subject: [PATCH 5/7] ARM64: zynqmp: Enable watchdog on ep108
In-Reply-To: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
Message-ID: <f2ad475f3889406acb73a972d95a79522d5d8ced.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable watchdog on ep108.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index d6cc4b583587..faee1617ab16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -70,3 +70,7 @@
 	dr_mode = "host";
 	maximum-speed = "high-speed";
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.3.5

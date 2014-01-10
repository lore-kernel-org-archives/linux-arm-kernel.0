From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 19:16:10 +0900
Subject: [PATCH 2/2] arm64: dts: use #include for all ARM fast model device
 tree file
In-Reply-To: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1389348970-5498-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert /include/ (dtc) with #include (C pre-processor) for
device tree file of ARM fast model.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
index 572005e..024f51e 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -154,6 +154,6 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 
-		/include/ "rtsm_ve-motherboard.dtsi"
+		#include "rtsm_ve-motherboard.dtsi"
 	};
 };
-- 
1.7.10.4

From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 12 Aug 2016 22:05:45 -0700
Subject: [PATCH net-next v2 09/12] dtb: xgene: Add rxlos-gpios property
In-Reply-To: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
References: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
Message-ID: <1471064748-28033-10-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added rxlos GPIO mapping by adding rxlos-gpios property.

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index b7fb5d9..32a961c 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -74,6 +74,7 @@
 
 &xgenet {
 	status = "ok";
+	rxlos-gpios = <&sbgpio 12 1>;
 };
 
 &mmc0 {
-- 
1.9.1

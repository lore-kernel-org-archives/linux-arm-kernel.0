From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 19:16:09 +0900
Subject: [PATCH 1/2] arm64: dts: use #include for all AppliedMicro device tree
 files
In-Reply-To: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389348970-5498-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1389348970-5498-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert /include/ (dtc) with #include (C pre-processor) for
device tree files of AppliedMicro boards.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm64/boot/dts/apm-mustang.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
index 1247ca1..6b5e9d2 100644
--- a/arch/arm64/boot/dts/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-/include/ "apm-storm.dtsi"
+#include "apm-storm.dtsi"
 
 / {
 	model = "APM X-Gene Mustang board";
-- 
1.7.10.4

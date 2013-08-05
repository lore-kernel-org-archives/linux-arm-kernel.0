From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:12 -0400
Subject: [RESEND PATCH 5/7] ARM: keystone: use #include to include
 skeleton.dtsi
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ (dtc) with #include (C pre-processor) to
include skeleton.dtsi

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 1334b42..612ba8c 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -7,7 +7,7 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	model = "Texas Instruments Keystone 2 SoC";
-- 
1.7.9.5

From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 24 Oct 2016 16:31:28 +0800
Subject: [PATCH 1/3] ARM: dts: hip01: Remove skeleton.dtsi inclusion
Message-ID: <1477297890-34899-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), remove deprecated skeleton.dtsi.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/boot/dts/hip01.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index 4e9562f..9d5fd5c 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -11,8 +11,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
-
 / {
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
-- 
1.7.12.4

From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 24 Oct 2016 16:31:30 +0800
Subject: [PATCH 3/3] ARM: dts: hisi-x5hd2: Remove skeleton.dtsi inclusion
In-Reply-To: <1477297890-34899-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1477297890-34899-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1477297890-34899-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), remove deprecated skeleton.dtsi.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index fdcc23d..506fdc1 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -7,10 +7,12 @@
  * publishhed by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/hix5hd2-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		serial0 = &uart0;
 	};
-- 
1.7.12.4

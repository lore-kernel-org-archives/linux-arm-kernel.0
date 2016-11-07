From: john.garry@huawei.com (John Garry)
Date: Tue, 8 Nov 2016 00:44:23 +0800
Subject: [PATCH 1/3] arm64: dts: hisi: fix hip06 sas am-max-trans quirk
In-Reply-To: <1478537065-169286-1-git-send-email-john.garry@huawei.com>
References: <1478537065-169286-1-git-send-email-john.garry@huawei.com>
Message-ID: <1478537065-169286-2-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The string for the am max transmissions quirk property
is not correct -> fix it.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index b548763..5330abb 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -590,7 +590,7 @@
 			reg = <0 0xa2000000 0 0x10000>;
 			sas-addr = [50 01 88 20 16 00 00 00];
 			hisilicon,sas-syscon = <&pcie_subctl>;
-			am-max-trans;
+			hip06-sas-v2-quirk-amt;
 			ctrl-reset-reg = <0xa18>;
 			ctrl-reset-sts-reg = <0x5a0c>;
 			ctrl-clock-ena-reg = <0x318>;
-- 
1.9.1

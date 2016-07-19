From: kid.jin@hisilicon.com (Jin Guojun)
Date: Tue, 19 Jul 2016 15:51:53 +0800
Subject: [PATCH 2/2] Enable SD UHS mode for hikey-mainline-rebase
In-Reply-To: <1468914713-63347-1-git-send-email-kid.jin@hisilicon.com>
References: <1468914713-63347-1-git-send-email-kid.jin@hisilicon.com>
Message-ID: <1468914713-63347-2-git-send-email-kid.jin@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: j00226943 <j00226943@notesmail.huawei.com>

One more changes:

Enable SDR12 SDR25 SDR50 SDR104 in DTS to support UHS for SD Card

Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 189d215..33f204f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -761,6 +761,10 @@
 			card-detect-delay = <200>;
 			hisilicon,peripheral-syscon = <&ao_ctrl>;
 			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
 			reg = <0x0 0xf723e000 0x0 0x1000>;
 			interrupts = <0x0 0x49 0x4>;
 			#address-cells = <0x1>;
-- 
1.8.3.2

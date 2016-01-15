From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:51 +0800
Subject: [PATCH v3 4/9] ARM: dts: rockchip: enable the uart0 for kylin board
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is enabling the uart0 for bluetooth module.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3: None

 arch/arm/boot/dts/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 30a9aca..2a45be7 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -316,6 +316,10 @@
 	status = "okay";
 };
 
+&uart0 {
+	status = "okay";
+};
+
 &usb_host {
 	status = "okay";
 };
-- 
1.9.1

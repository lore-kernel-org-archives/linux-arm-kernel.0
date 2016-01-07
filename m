From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  7 Jan 2016 16:25:52 +0800
Subject: [PATCH v2 09/12] ARM: dts: rockchip: enable the uart0 for kylin board
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452155155-16232-10-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is enabling the uart0 for bluetooth module.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- Add the uart0 commit content.

 arch/arm/boot/dts/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 4346ce5..c5e46f9 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -361,6 +361,10 @@
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

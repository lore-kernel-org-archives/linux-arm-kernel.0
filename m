From: xuwei5@hisilicon.com (Wei.Xu)
Date: Fri, 7 Apr 2017 10:07:56 +0800
Subject: [PATCH 5/5] arm64: dts: hisi: enalbe the NIC and SAS for the
 hip07-d05 board
In-Reply-To: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
References: <1491530876-109791-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <1491530876-109791-6-git-send-email-xuwei5@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Xu <xuwei5@hisilicon.com>

Enalbe the NIC and SAS nodes for the hip07-d05 board
to support related functions.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
index e058442..5bdca80 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip07-d05.dts
@@ -64,3 +64,27 @@
 &usb_ehci {
 	status = "ok";
 };
+
+&eth0 {
+	status = "ok";
+};
+
+&eth1 {
+	status = "ok";
+};
+
+&eth2 {
+	status = "ok";
+};
+
+&eth3 {
+	status = "ok";
+};
+
+&p0_pcie2_a {
+	status = "ok";
+};
+
+&sas1 {
+	status = "ok";
+};
-- 
1.9.1

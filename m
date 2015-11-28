From: yankejian@huawei.com (yankejian)
Date: Sat, 28 Nov 2015 14:15:14 +0800
Subject: [PATCH net-next 1/3] dts: hisi: enables the ethX for D02 board
In-Reply-To: <1448691316-236111-1-git-send-email-yankejian@huawei.com>
References: <1448691316-236111-1-git-send-email-yankejian@huawei.com>
Message-ID: <1448691316-236111-2-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch enables the ethX for D02 board on hip05-d02.dts. otherwise it
cannot find hns ethX by ifconfig -a.

Signed-off-by: yankejian <yankejian@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index ae34e25..6aa5cb2 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -34,3 +34,19 @@
 &uart0 {
 	status = "ok";
 };
+
+&eth2 {
+	status = "okay";
+};
+
+&eth3 {
+	status = "okay";
+};
+
+&eth6 {
+	status = "okay";
+};
+
+&eth7 {
+	status = "okay";
+};
-- 
1.9.1

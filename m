From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:58 +0000
Subject: [PATCH 04/10] ARM: dts: atlas7: add alias name for spi device
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

spi framework can use alias name of spi device to retrieve the bus id,
so bus id will not be dynamical but statical and it will be easier for
test for a specified spi device with a fixed name like use spidev.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index cc9db08..b872d12 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -21,6 +21,10 @@
 		serial5 = &uart5;
 		serial6 = &uart6;
 		serial9 = &usp2;
+		spi1 = &spi1;
+		spi2 = &usp1;
+		spi3 = &usp2;
+		spi4 = &usp3;
 	};
 	cpus {
 		#address-cells = <1>;
-- 
1.9.1

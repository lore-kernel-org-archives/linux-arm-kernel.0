From: Baohua.Song@csr.com (Barry Song)
Date: Sun, 4 Sep 2011 22:15:16 -0700
Subject: [PATCH 1/3] ARM: CSR: add lost Resource Sharing Control(RSC) node in
	dts
Message-ID: <1315199718-10102-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2-cb.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
index 6fecc88..a0a423d 100644
--- a/arch/arm/boot/dts/prima2-cb.dts
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -67,6 +67,11 @@
 				compatible = "sirf,prima2-rstc";
 				reg = <0x88010000 0x1000>;
 			};
+
+			rsc-controller at 88020000 {
+				compatible = "sirf,prima2-rsc";
+				reg = <0x88020000 0x1000>;
+			};
 		};
 
 		mem-iobg {
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:46:48 +0800
Subject: [PATCH 2/2] ARM: dts: prima2: add I2S 2ch, 6ch, nodin, mclk groups
In-Reply-To: <1409651208-5820-1-git-send-email-Barry.Song@csr.com>
References: <1409651208-5820-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409651208-5820-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

we have done that for atlas6 in commit ed36c1a, 086b8904 etc. here we
do same things for prima2.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 963b7e5..bc6e611 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -524,12 +524,36 @@
                                                 sirf,function = "sdmmc5";
                                         };
                                 };
+				i2s_mclk_pins_a: i2s_mclk at 0 {
+                                        i2s_mclk {
+                                                sirf,pins = "i2smclkgrp";
+                                                sirf,function = "i2s_mclk";
+                                        };
+                                };
+				i2s_ext_clk_input_pins_a: i2s_ext_clk_input at 0 {
+                                        i2s_ext_clk_input {
+                                                sirf,pins = "i2s_ext_clk_inputgrp";
+                                                sirf,function = "i2s_ext_clk_input";
+                                        };
+                                };
                                 i2s_pins_a: i2s at 0 {
                                         i2s {
                                                 sirf,pins = "i2sgrp";
                                                 sirf,function = "i2s";
                                         };
                                 };
+				i2s_no_din_pins_a: i2s_no_din at 0 {
+                                        i2s_no_din {
+                                                sirf,pins = "i2s_no_dingrp";
+                                                sirf,function = "i2s_no_din";
+                                        };
+                                };
+				i2s_6chn_pins_a: i2s_6chn at 0 {
+                                        i2s_6chn {
+                                                sirf,pins = "i2s_6chngrp";
+                                                sirf,function = "i2s_6chn";
+                                        };
+                                };
                                 ac97_pins_a: ac97 at 0 {
                                         ac97 {
                                                 sirf,pins = "ac97grp";
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.

From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  3 Oct 2013 23:21:40 +0200
Subject: [PATCH v2 4/5] ARM: socfpga: dts: cleanup indentation
In-Reply-To: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1380835301-26512-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1380835301-26512-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the clock nodes and the rst-/sysmgr use wrong indentation.
Fix it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 290 ++++++++++++++++++++---------------------
 1 file changed, 145 insertions(+), 145 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index e273fa9..587096e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -243,197 +243,197 @@
 						};
 					};
 
-				mpu_periph_clk: mpu_periph_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mpuclk>;
-					fixed-divider = <4>;
+					mpu_periph_clk: mpu_periph_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mpuclk>;
+						fixed-divider = <4>;
 					};
 
-				mpu_l2_ram_clk: mpu_l2_ram_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mpuclk>;
-					fixed-divider = <2>;
+					mpu_l2_ram_clk: mpu_l2_ram_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mpuclk>;
+						fixed-divider = <2>;
 					};
 
-				l4_main_clk: l4_main_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>;
-					clk-gate = <0x60 0>;
+					l4_main_clk: l4_main_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>;
+						clk-gate = <0x60 0>;
 					};
 
-				l3_main_clk: l3_main_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>;
+					l3_main_clk: l3_main_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>;
 					};
 
-				l3_mp_clk: l3_mp_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>;
-					div-reg = <0x64 0 2>;
-					clk-gate = <0x60 1>;
+					l3_mp_clk: l3_mp_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>;
+						div-reg = <0x64 0 2>;
+						clk-gate = <0x60 1>;
 					};
 
-				l3_sp_clk: l3_sp_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>;
-					div-reg = <0x64 2 2>;
-				};
+					l3_sp_clk: l3_sp_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>;
+						div-reg = <0x64 2 2>;
+					};
 
-				l4_mp_clk: l4_mp_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>, <&per_base_clk>;
-					div-reg = <0x64 4 3>;
-					clk-gate = <0x60 2>;
+					l4_mp_clk: l4_mp_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>, <&per_base_clk>;
+						div-reg = <0x64 4 3>;
+						clk-gate = <0x60 2>;
 					};
 
-				l4_sp_clk: l4_sp_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&mainclk>, <&per_base_clk>;
-					div-reg = <0x64 7 3>;
-					clk-gate = <0x60 3>;
+					l4_sp_clk: l4_sp_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&mainclk>, <&per_base_clk>;
+						div-reg = <0x64 7 3>;
+						clk-gate = <0x60 3>;
 					};
 
-				dbg_at_clk: dbg_at_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&dbg_base_clk>;
-					div-reg = <0x68 0 2>;
-					clk-gate = <0x60 4>;
+					dbg_at_clk: dbg_at_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&dbg_base_clk>;
+						div-reg = <0x68 0 2>;
+						clk-gate = <0x60 4>;
 					};
 
-				dbg_clk: dbg_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&dbg_base_clk>;
-					div-reg = <0x68 2 2>;
-					clk-gate = <0x60 5>;
+					dbg_clk: dbg_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&dbg_base_clk>;
+						div-reg = <0x68 2 2>;
+						clk-gate = <0x60 5>;
 					};
 
-				dbg_trace_clk: dbg_trace_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&dbg_base_clk>;
-					div-reg = <0x6C 0 3>;
-					clk-gate = <0x60 6>;
+					dbg_trace_clk: dbg_trace_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&dbg_base_clk>;
+						div-reg = <0x6C 0 3>;
+						clk-gate = <0x60 6>;
 					};
 
-				dbg_timer_clk: dbg_timer_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&dbg_base_clk>;
-					clk-gate = <0x60 7>;
+					dbg_timer_clk: dbg_timer_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&dbg_base_clk>;
+						clk-gate = <0x60 7>;
 					};
 
-				cfg_clk: cfg_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&cfg_s2f_usr0_clk>;
-					clk-gate = <0x60 8>;
+					cfg_clk: cfg_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&cfg_s2f_usr0_clk>;
+						clk-gate = <0x60 8>;
 					};
 
-				s2f_user0_clk: s2f_user0_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&cfg_s2f_usr0_clk>;
-					clk-gate = <0x60 9>;
+					s2f_user0_clk: s2f_user0_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&cfg_s2f_usr0_clk>;
+						clk-gate = <0x60 9>;
 					};
 
-				emac_0_clk: emac_0_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&emac0_clk>;
-					clk-gate = <0xa0 0>;
+					emac_0_clk: emac_0_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&emac0_clk>;
+						clk-gate = <0xa0 0>;
 					};
 
-				emac_1_clk: emac_1_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&emac1_clk>;
-					clk-gate = <0xa0 1>;
+					emac_1_clk: emac_1_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&emac1_clk>;
+						clk-gate = <0xa0 1>;
 					};
 
-				usb_mp_clk: usb_mp_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&per_base_clk>;
-					clk-gate = <0xa0 2>;
-					div-reg = <0xa4 0 3>;
+					usb_mp_clk: usb_mp_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&per_base_clk>;
+						clk-gate = <0xa0 2>;
+						div-reg = <0xa4 0 3>;
 					};
 
-				spi_m_clk: spi_m_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&per_base_clk>;
-					clk-gate = <0xa0 3>;
-					div-reg = <0xa4 3 3>;
+					spi_m_clk: spi_m_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&per_base_clk>;
+						clk-gate = <0xa0 3>;
+						div-reg = <0xa4 3 3>;
 					};
 
-				can0_clk: can0_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&per_base_clk>;
-					clk-gate = <0xa0 4>;
-					div-reg = <0xa4 6 3>;
+					can0_clk: can0_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&per_base_clk>;
+						clk-gate = <0xa0 4>;
+						div-reg = <0xa4 6 3>;
 					};
 
-				can1_clk: can1_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&per_base_clk>;
-					clk-gate = <0xa0 5>;
-					div-reg = <0xa4 9 3>;
+					can1_clk: can1_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&per_base_clk>;
+						clk-gate = <0xa0 5>;
+						div-reg = <0xa4 9 3>;
 					};
 
-				gpio_db_clk: gpio_db_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&per_base_clk>;
-					clk-gate = <0xa0 6>;
-					div-reg = <0xa8 0 24>;
+					gpio_db_clk: gpio_db_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&per_base_clk>;
+						clk-gate = <0xa0 6>;
+						div-reg = <0xa8 0 24>;
 					};
 
-				s2f_user1_clk: s2f_user1_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&s2f_usr1_clk>;
-					clk-gate = <0xa0 7>;
+					s2f_user1_clk: s2f_user1_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&s2f_usr1_clk>;
+						clk-gate = <0xa0 7>;
 					};
 
-				sdmmc_clk: sdmmc_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
-					clk-gate = <0xa0 8>;
+					sdmmc_clk: sdmmc_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+						clk-gate = <0xa0 8>;
 					};
 
-				nand_x_clk: nand_x_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
-					clk-gate = <0xa0 9>;
+					nand_x_clk: nand_x_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+						clk-gate = <0xa0 9>;
 					};
 
-				nand_clk: nand_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
-					clk-gate = <0xa0 10>;
-					fixed-divider = <4>;
+					nand_clk: nand_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
+						clk-gate = <0xa0 10>;
+						fixed-divider = <4>;
 					};
 
-				qspi_clk: qspi_clk {
-					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
-					clocks = <&f2s_periph_ref_clk>, <&main_qspi_clk>, <&per_qspi_clk>;
-					clk-gate = <0xa0 11>;
+					qspi_clk: qspi_clk {
+						#clock-cells = <0>;
+						compatible = "altr,socfpga-gate-clk";
+						clocks = <&f2s_periph_ref_clk>, <&main_qspi_clk>, <&per_qspi_clk>;
+						clk-gate = <0xa0 11>;
 					};
 				};
 			};
@@ -516,9 +516,9 @@
 		};
 
 		rstmgr at ffd05000 {
-				compatible = "altr,rst-mgr";
-				reg = <0xffd05000 0x1000>;
-			};
+			compatible = "altr,rst-mgr";
+			reg = <0xffd05000 0x1000>;
+		};
 
 		sysmgr at ffd08000 {
 				compatible = "altr,sys-mgr";
-- 
1.8.4.rc3

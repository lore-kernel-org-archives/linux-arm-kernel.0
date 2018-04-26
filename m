From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 Apr 2018 10:36:28 +0200
Subject: [PATCH] ARM64: dts: meson-axg: add tdm pins
In-Reply-To: <20180417064035.28776-1-jbrunet@baylibre.com>
References: <20180417064035.28776-1-jbrunet@baylibre.com>
Message-ID: <49f6e142-f958-c86a-e951-a3eb7aa4e720@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/2018 08:40, Jerome Brunet wrote:
> Add tdm pins to amlogic's A113 device tree
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 245 +++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b58808eb3cc8..74013965e86a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -660,6 +660,251 @@
>  						function = "uart_ao_b_z";
>  					};
>  				};
> +
> +				mclk_b_pins: mclk_b {
> +					mux {
> +						groups = "mclk_b";
> +						function = "mclk_b";
> +					};
> +				};
> +
> +				mclk_c_pins: mclk_c {
> +					mux {
> +						groups = "mclk_c";
> +						function = "mclk_c";
> +					};
> +				};
> +
> +				tdma_sclk_pins: tdma_sclk {
> +					mux {
> +						groups = "tdma_sclk";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_sclk_slv_pins: tdma_sclk_slv {
> +					mux {
> +						groups = "tdma_sclk_slv";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_fs_pins: tdma_fs {
> +					mux {
> +						groups = "tdma_fs";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_fs_slv_pins: tdma_fs_slv {
> +					mux {
> +						groups = "tdma_fs_slv";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_din0_pins: tdma_din0 {
> +					mux {
> +						groups = "tdma_din0";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout0_x14_pins: tdma_dout0_x14 {
> +					mux {
> +						groups = "tdma_dout0_x14";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout0_x15_pins: tdma_dout0_x15 {
> +					mux {
> +						groups = "tdma_dout0_x15";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout1_pins: tdma_dout1 {
> +					mux {
> +						groups = "tdma_dout1";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_din1_pins: tdma_din1 {
> +					mux {
> +						groups = "tdma_din1";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdmb_sclk_pins: tdmb_sclk {
> +					mux {
> +						groups = "tdmb_sclk";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_sclk_slv_pins: tdmb_sclk_slv {
> +					mux {
> +						groups = "tdmb_sclk_slv";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_fs_pins: tdmb_fs {
> +					mux {
> +						groups = "tdmb_fs";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_fs_slv_pins: tdmb_fs_slv {
> +					mux {
> +						groups = "tdmb_fs_slv";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din0_pins: tdmb_din0 {
> +					mux {
> +						groups = "tdmb_din0";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout0_pins: tdmb_dout0 {
> +					mux {
> +						groups = "tdmb_dout0";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din1_pins: tdmb_din1 {
> +					mux {
> +						groups = "tdmb_din1";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout1_pins: tdmb_dout1 {
> +					mux {
> +						groups = "tdmb_dout1";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din2_pins: tdmb_din2 {
> +					mux {
> +						groups = "tdmb_din2";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout2_pins: tdmb_dout2 {
> +					mux {
> +						groups = "tdmb_dout2";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din3_pins: tdmb_din3 {
> +					mux {
> +						groups = "tdmb_din3";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout3_pins: tdmb_dout3 {
> +					mux {
> +						groups = "tdmb_dout3";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmc_sclk_pins: tdmc_sclk {
> +					mux {
> +						groups = "tdmc_sclk";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_sclk_slv_pins: tdmc_sclk_slv {
> +					mux {
> +						groups = "tdmc_sclk_slv";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_fs_pins: tdmc_fs {
> +					mux {
> +						groups = "tdmc_fs";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_fs_slv_pins: tdmc_fs_slv {
> +					mux {
> +						groups = "tdmc_fs_slv";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din0_pins: tdmc_din0 {
> +					mux {
> +						groups = "tdmc_din0";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout0_pins: tdmc_dout0 {
> +					mux {
> +						groups = "tdmc_dout0";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din1_pins: tdmc_din1 {
> +					mux {
> +						groups = "tdmc_din1";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout1_pins: tdmc_dout1 {
> +					mux {
> +						groups = "tdmc_dout1";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din2_pins: tdmc_din2 {
> +					mux {
> +						groups = "tdmc_din2";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout2_pins: tdmc_dout2 {
> +					mux {
> +						groups = "tdmc_dout2";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din3_pins: tdmc_din3 {
> +					mux {
> +						groups = "tdmc_din3";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout3_pins: tdmc_dout3 {
> +					mux {
> +						groups = "tdmc_dout3";
> +						function = "tdmc";
> +					};
> +				};
>  			};
>  		};
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

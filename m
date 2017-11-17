From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:06:18 +0100
Subject: [PATCH 4/5] ARM64: dts: meson-axg: describe pin DT info for I2C
 controller
In-Reply-To: <20171117080236.32504-5-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-5-yixun.lan@amlogic.com>
Message-ID: <4cec4212-0f15-d177-c42d-7fa436513c30@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/2017 09:02, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Describe all the pin mux for the I2C controller which found in
> Meson-AXG SoC.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 64 ++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 99e967aff439..edbfd6022078 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -304,6 +304,70 @@
>  						function = "eth";
>  					};
>  				};
> +
> +				i2c_m0_pins: i2c_m0 {
> +					mux {
> +						groups = "i2c_sck_m0",
> +							"i2c_sda_m0";
> +						function = "i2c_m0";
> +					};
> +				};
> +
> +				i2c_m1_z_pins: i2c_m1_z {
> +					mux {
> +						groups = "i2c_sck_m1_z",
> +							"i2c_sda_m1_z";
> +						function = "i2c_m1";
> +					};
> +				};
> +
> +				i2c_m1_x_pins: i2c_m1_x {
> +					mux {
> +						groups = "i2c_sck_m1_x",
> +							"i2c_sda_m1_x";
> +						function = "i2c_m1";
> +					};
> +				};
> +
> +				i2c_m2_x_pins: i2c_m2_x {
> +					mux {
> +						groups = "i2c_sck_m2_x",
> +							"i2c_sda_m2_x";
> +						function = "i2c_m2";
> +					};
> +				};
> +
> +				i2c_m2_a_pins: i2c_m2_a {
> +					mux {
> +						groups = "i2c_sck_m2_a",
> +							"i2c_sda_m2_a";
> +						function = "i2c_m2";
> +					};
> +				};
> +
> +				i2c_m3_a6_pins: i2c_m3_a6 {
> +					mux {
> +						groups = "i2c_sda_m3_a6",
> +							"i2c_sck_m3_a7";
> +						function = "i2c_m3";
> +					};
> +				};
> +
> +				i2c_m3_a12_pins: i2c_m3_a12 {
> +					mux {
> +						groups = "i2c_sda_m3_a12",
> +							"i2c_sck_m3_a13";
> +						function = "i2c_m3";
> +					};
> +				};
> +
> +				i2c_m3_a19_pins: i2c_m3_a19 {
> +					mux {
> +						groups = "i2c_sda_m3_a19",
> +							"i2c_sck_m3_a20";
> +						function = "i2c_m3";
> +					};
> +				};
>  			};
>  		};
>  
> 

Same here fore the naming of the i2c nodes.

Neil

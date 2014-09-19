From: stefan@agner.ch (Stefan Agner)
Date: Fri, 19 Sep 2014 18:22:59 +0200
Subject: [PATCH v2] ARM: dts: vf610-colibri: Add ADC support
In-Reply-To: <a0ecfce3f97fb6684657ae76b89f38108fcdf68f.1411122224.git.maitysanchayan@gmail.com>
References: <cover.1411122224.git.maitysanchayan@gmail.com>
 <a0ecfce3f97fb6684657ae76b89f38108fcdf68f.1411122224.git.maitysanchayan@gmail.com>
Message-ID: <7227b2c6dd75118b3f892ee768392711@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-19 13:26, schrieb Sanchayan Maity:
> Enable ADC support for Colibri VF61 modules
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-colibri.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi
> b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 0cd8343..6fd099e 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -27,6 +27,16 @@
>  
>  };
>  
> +&adc0 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;

Acked-By: Stefan Agner <stefan@agner.ch>

--
Stefan

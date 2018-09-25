From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Sep 2018 23:18:22 +0800
Subject: [PATCH 5/6] ARM: dts: vf610-zii-cfu1: Pass the 'no-sdio' property
In-Reply-To: <1536696647-8228-5-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
 <1536696647-8228-5-git-send-email-festevam@gmail.com>
Message-ID: <20180925151821.GG21282@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 05:10:46PM -0300, Fabio Estevam wrote:
> No SDIO devices are connected to these ports, so pass the 'no-sdio'
> property.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

@Andrey, are you okay?

Shawn

> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index de3ed03..aba4cec 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -122,6 +122,7 @@
>  	non-removable;
>  	no-1-8-v;
>  	keep-power-in-suspend;
> +	no-sdio;
>  	status = "okay";
>  };
>  
> @@ -129,6 +130,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
>  	bus-width = <4>;
> +	no-sdio;
>  	status = "okay";
>  };
>  
> -- 
> 2.7.4
> 

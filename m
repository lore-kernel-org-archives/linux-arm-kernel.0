From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 19:09:18 -0400
Subject: [PATCH V2 07/10] ARM: mvebu: Use standard MMC binding for all
 users of mvsdio
In-Reply-To: <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-8-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130513230918.GG31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:18:58PM +0200, Simon Baatz wrote:
> In order to prepare the switch to the standard MMC device tree parser
> for mvsdio, adapt all current uses of mvsdio in the dts files to the
> standard format.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
...
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index 7588241..bf3a58c 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -136,7 +136,7 @@
>  			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
>  			pinctrl-names = "default";
>  			status = "okay";
> -			cd-gpios = <&gpio1 15 0>;
> +			cd-gpios = <&gpio1 15 1>;

Is this a bugfix that should be backported?

thx,

Jason.

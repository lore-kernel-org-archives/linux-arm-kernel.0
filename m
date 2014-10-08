From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Oct 2014 21:18:29 -0300
Subject: [PATCH] ARM: dts: imx28-evk: remove duplicate property
In-Reply-To: <1412715639-9565-1-git-send-email-mhei@heimpold.de>
References: <1412715639-9565-1-git-send-email-mhei@heimpold.de>
Message-ID: <CAOMZO5Cr2Or5O0c0xjL2Z_Gj6HDGk5vhRckVYw6Q58U+JoZOfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 7, 2014 at 6:00 PM, Michael Heimpold <mhei@heimpold.de> wrote:
> Seems to be a left-over from an automatic merge.
>
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index 09664fc..2944d39 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -182,7 +182,6 @@
>                         };
>
>                         lradc at 80050000 {
> -                               fsl,lradc-touchscreen-wires = <4>;

Thanks

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

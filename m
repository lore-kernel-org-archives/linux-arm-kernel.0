From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Jan 2013 09:13:50 +0800
Subject: [PATCH] ARM: dts: imx25-karo-tx25: Put status entry in the end
In-Reply-To: <1357302549-12746-1-git-send-email-fabio.estevam@freescale.com>
References: <1357302549-12746-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130105011348.GH1887@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 10:29:09AM -0200, Fabio Estevam wrote:
> Just to keep consistency with other dts files, place 'status' entry as the last
> one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx25-karo-tx25.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
> index eb9b9d1..1a9d049 100644
> --- a/arch/arm/boot/dts/imx25-karo-tx25.dts
> +++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
> @@ -26,8 +26,8 @@
>  };
>  
>  &fec {
> -	status = "okay";
>  	phy-mode = "rmii";
> +	status = "okay";
>  };
>  
>  &nfc {
> -- 
> 1.7.9.5
> 
> 

From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 May 2013 11:12:09 +0800
Subject: [PATCH 1/3] ARM: dts: Add aliases for i.MX27 SPI controller
In-Reply-To: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
References: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130502031207.GG3442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 02:46:57PM +0400, Alexander Shiyan wrote:
> Add aliases to determine the proper SPI bus number.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx27.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index ff4bd48..cd85828 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -25,6 +25,9 @@
>  		gpio3 = &gpio4;
>  		gpio4 = &gpio5;
>  		gpio5 = &gpio6;
> +		spi0 = &cspi1;
> +		spi1 = &cspi2;
> +		spi2 = &cspi3;
>  	};
>  
>  	avic: avic-interrupt-controller at e0000000 {
> -- 
> 1.8.1.5
> 

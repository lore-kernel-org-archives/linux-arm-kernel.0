From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 09:59:10 +0200
Subject: [PATCH 1/1] ARM: at91sam9260: dt: uart1 fix pinctrl typo
In-Reply-To: <1366141672-10302-1-git-send-email-plagnioj@jcrosoft.com>
References: <1366141672-10302-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <516FA7CE.7030109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 09:47 PM, Jean-Christophe PLAGNIOL-VILLARD :
> it's bank B not C

Already seen by Douglas Gilbert and queued for 3.10 in arm-soc/at91/dt3

Thanks anyway, bye.

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Reported-by: Adam Porter <porter.adam@gmail.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 367a604..6980ed1 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -220,8 +220,8 @@
>  				uart1 {
>  					pinctrl_uart1: uart1-0 {
>  						atmel,pins =
> -							<2 12 0x1 0x1	/* PB12 periph A with pullup */
> -							 2 13 0x1 0x0>;	/* PB13 periph A */
> +							<1 12 0x1 0x1	/* PB12 periph A with pullup */
> +							 1 13 0x1 0x0>;	/* PB13 periph A */
>  					};
>  				};
>  
> 


-- 
Nicolas Ferre

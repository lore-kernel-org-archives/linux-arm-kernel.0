From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Jan 2013 10:12:35 +0100
Subject: [PATCH] ARM: at91: at91sam9x5: fix usart3 pinctrl name
In-Reply-To: <1359387816-11730-1-git-send-email-robertcnelson@gmail.com>
References: <1359387816-11730-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <5108E403.9060504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2013 04:43 PM, Robert Nelson :
> The renaming of pinctrl_uart3 to pinctrl_usart3 was missed in:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=9e3129e937e2f178d2a003ea45765e5e63e34665
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

With little reformatting of commit message, queued in at91-fixes.

Thanks a lot!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 8ecca69..464e34f 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -197,7 +197,7 @@
>  				};
>  
>  				usart3 {
> -					pinctrl_uart3: usart3-0 {
> +					pinctrl_usart3: usart3-0 {
>  						atmel,pins =
>  							<2 23 0x2 0x1	/* PC22 periph B with pullup */
>  							 2 23 0x2 0x0>;	/* PC23 periph B */
> 


-- 
Nicolas Ferre

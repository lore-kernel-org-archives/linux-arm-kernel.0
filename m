From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 May 2013 12:19:53 +0200
Subject: [PATCH 1/1] ARM: at91: at91sam9x25ek: fix model name
In-Reply-To: <1367957217-3678-1-git-send-email-plagnioj@jcrosoft.com>
References: <1367957217-3678-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <518CC9C9.2000806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 22:06, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

added the stable tag:

Cc: stable <stable@vger.kernel.org> # 3.8+

and pushed in at91-3.10-fixes branch.
Thanks.

> ---
>   arch/arm/boot/dts/at91sam9x25ek.dts |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91sam9x25ek.dts
> index 8ddbce0..4948648 100644
> --- a/arch/arm/boot/dts/at91sam9x25ek.dts
> +++ b/arch/arm/boot/dts/at91sam9x25ek.dts
> @@ -11,7 +11,7 @@
>   #include "at91sam9x5ek.dtsi"
>
>   / {
> -	model = "Atmel AT91SAM9G25-EK";
> +	model = "Atmel AT91SAM9X25-EK";
>   	compatible = "atmel,at91sam9x25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
>
>   	ahb {
>

-- 
Nicolas Ferre

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 Jan 2014 11:59:24 +0100
Subject: [PATCH] at91: dt: i2c: add a new compatibility string for the
 at91sam9261
In-Reply-To: <1389781467-29626-1-git-send-email-jjhiblot@traphandler.com>
References: <1389781467-29626-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52D66A0C.4090509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2014 11:24, Jean-Jacques Hiblot :
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Jean-Jacques.

Side note: do not forget i2c maintainer and ml.

> ---
>  drivers/i2c/busses/i2c-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 8edba9d..843d012 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -589,6 +589,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
>  		.compatible = "atmel,at91sam9260-i2c",
>  		.data = &at91sam9260_config,
>  	} , {
> +		.compatible = "atmel,at91sam9261-i2c",
> +		.data = &at91sam9261_config,
> +	} , {
>  		.compatible = "atmel,at91sam9g20-i2c",
>  		.data = &at91sam9g20_config,
>  	} , {
> 


-- 
Nicolas Ferre

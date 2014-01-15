From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jan 2014 12:09:01 +0100
Subject: [PATCH] at91: dt: i2c: add a new compatibility string for the
 at91sam9261
In-Reply-To: <1389781467-29626-1-git-send-email-jjhiblot@traphandler.com>
References: <1389781467-29626-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140115110901.GQ17817@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 11:24:27AM +0100, Jean-Jacques Hiblot wrote:
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

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
> -- 
> 1.8.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

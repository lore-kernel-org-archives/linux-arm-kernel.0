From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 Aug 2014 14:02:18 -0500
Subject: [PATCH] mmc: atmel-mci: add 0x600 IP version
In-Reply-To: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
References: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <53F39F3A.1090704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2014 02:47, Ludovic Desroches :
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Chris, Ufl,

It seems that this tiny patch got forgotten: Should we re-send it?

Thanks, bye,

> ---
>  drivers/mmc/host/atmel-mci.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 1b4b064..9c4c191 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>  
>  	/* keep only major version number */
>  	switch (version & 0xf00) {
> +	case 0x600:
>  	case 0x500:
>  		host->caps.has_odd_clk_div = 1;
>  	case 0x400:
> 


-- 
Nicolas Ferre

From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 27 Jan 2010 14:58:38 +0000
Subject: [PATCH 1/3] ARM: S3C2412: SoC has the fractional baud rate
	register
In-Reply-To: <1264601924-18480-1-git-send-email-buserror@gmail.com>
References: <1264601924-18480-1-git-send-email-buserror@gmail.com>
Message-ID: <20100127145838.GI10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:18:42PM +0000, Michel Pollet wrote:
> So add it's flag to the UART definition to allow
> generation of more precise baud rates for the various
> clock combinations.

Firstly, I'd like to see this read better by placing the subject at the
front of this description

Secondly, it would be nice to re-wrap it to closer to 77 chars/line.

 
> Signed-off-by: Michel Pollet <buserror@gmail.com>
> ---
>  drivers/serial/s3c2412.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/serial/s3c2412.c b/drivers/serial/s3c2412.c
> index ce75e28..1700b1a 100644
> --- a/drivers/serial/s3c2412.c
> +++ b/drivers/serial/s3c2412.c
> @@ -102,6 +102,7 @@ static struct s3c24xx_uart_info s3c2412_uart_inf = {
>  	.name		= "Samsung S3C2412 UART",
>  	.type		= PORT_S3C2412,
>  	.fifosize	= 64,
> +	.has_divslot	= 1,
>  	.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
>  	.rx_fifoshift	= S3C2440_UFSTAT_RXSHIFT,
>  	.rx_fifofull	= S3C2440_UFSTAT_RXFULL,
> -- 
> 1.6.6
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

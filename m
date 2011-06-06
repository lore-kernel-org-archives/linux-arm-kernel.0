From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 6 Jun 2011 16:44:30 +0200
Subject: [PATCH 2/3] pxa2xx trizeps4: pcmcia remove unnecessary ifdefs
In-Reply-To: <1307370255-15963-3-git-send-email-jic23@cam.ac.uk>
References: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
	<1307370255-15963-3-git-send-email-jic23@cam.ac.uk>
Message-ID: <201106061644.30567.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 06, 2011 04:24:14 PM Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/pcmcia/pxa2xx_trizeps4.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c
> b/drivers/pcmcia/pxa2xx_trizeps4.c index b829e65..57ddb96 100644
> --- a/drivers/pcmcia/pxa2xx_trizeps4.c
> +++ b/drivers/pcmcia/pxa2xx_trizeps4.c
> @@ -55,10 +55,6 @@ static int trizeps_pcmcia_hw_init(struct
> soc_pcmcia_socket *skt) }
>  		skt->socket.pci_irq = IRQ_GPIO(GPIO_PRDY);
>  		break;
> -
> -#ifndef CONFIG_MACH_TRIZEPS_CONXS
> -	case 1:
> -#endif
>  	default:
>  		break;
>  	}
Please add my

Acked-by: Marek Vasut <marek.vasut@gmail.com>

Thanks, cheers

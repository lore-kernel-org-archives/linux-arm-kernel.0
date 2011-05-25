From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 May 2011 20:48:23 +0200
Subject: [PATCH] mainatiners: add dma engine tree details
In-Reply-To: <1306346966-16385-1-git-send-email-vinod.koul@intel.com>
References: <1306346966-16385-1-git-send-email-vinod.koul@intel.com>
Message-ID: <20110525184823.GC22361@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a minor note:

$subject ~= s/mainatiners/maintainers/

Best regards
Uwe

On Wed, May 25, 2011 at 11:39:26PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  MAINTAINERS |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f44130..4435893 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2169,6 +2169,8 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  S:	Supported
>  F:	drivers/dma/
>  F:	include/linux/dma*
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git
> +T:	git git://git.infradead.org/users/vkoul/slave-dma.git (slave-dma)
>  
>  DME1737 HARDWARE MONITOR DRIVER
>  M:	Juerg Haefliger <juergh@gmail.com>
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

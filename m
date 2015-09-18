From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:32:18 +0200
Subject: [PATCH] MAINTAINERS: explicitly add Atmel SAMA5
In-Reply-To: <1441211061-11872-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1441211061-11872-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55FC2072.20900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/09/2015 18:24, Alexandre Belloni a ?crit :
> Atmel SAMA5 SoCs are also supported through mach-at91.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Absolutely:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60e2b2369d2..e8a40437727c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -891,7 +891,7 @@ M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
>  S:	Maintained
>  F:	arch/arm/mach-alpine/
>  
> -ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
> +ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
>  M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
>  M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> 


-- 
Nicolas Ferre

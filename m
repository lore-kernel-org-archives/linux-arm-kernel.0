From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Jan 2011 14:36:00 +0100
Subject: [PATCH] MAINTAINERS: Update Atmel AT91 entry
In-Reply-To: <1294250698-13275-1-git-send-email-nicolas.ferre@atmel.com>
References: <1294250698-13275-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4D2DAE40.80803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/01/2011 19:04, Nicolas Ferre :
> Add two co-maintainers and update the entry with new information.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Andrew Victor <linux@maxim.org.za>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Hi Andrew (Morton),

Maybe you can handle this "MAINTAINERS" patch?

Thanks a lot, bye.

> ---
>  MAINTAINERS |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7585e9d..cb58500 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -552,11 +552,15 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  
> -ARM/ATMEL AT91RM9200 ARM ARCHITECTURE
> +ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES
>  M:	Andrew Victor <linux@maxim.org.za>
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
> +M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://maxim.org.za/at91_26.html
> -S:	Maintained
> +W:	http://www.linux4sam.org
> +S:	Supported
> +F:	arch/arm/mach-at91/
>  
>  ARM/BCMRING ARM ARCHITECTURE
>  M:	Jiandong Zheng <jdzheng@broadcom.com>


-- 
Nicolas Ferre

From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 00:49:20 +0200
Subject: [PATCH v4 15/28] MAINTAINERS: Add Actions Semi Owl section
In-Reply-To: <20170606005426.26446-16-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-16-afaerber@suse.de>
Message-ID: <c68b8edf-9609-0147-6eeb-83793dc3adef@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3 -> v4: unchanged
>  
>  v2: new
>  
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f17ffa17abef..a9faa30def9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1036,6 +1036,16 @@ S:	Maintained
>  F:	drivers/amba/
>  F:	include/linux/amba/bus.h
>  
> +ARM/ACTIONS SEMI ARCHITECTURE
> +M:	Andreas F?rber <afaerber@suse.de>> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +N:	owl
> +F:	arch/arm/mach-actions/
> +F:	arch/arm/boot/dts/s500*

This will need to be updated for owl-s500*

> +F:	arch/arm64/boot/dts/actions/
> +F:	Documentation/devicetree/bindings/arm/actions.txt

This is lacking the two clocksource files.

> +
>  ARM/ADS SPHERE MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

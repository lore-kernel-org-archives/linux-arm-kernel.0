From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 27 May 2014 14:26:21 +0200
Subject: [PATCH] MAINTAINERS: add AT91 Clock Support entry
In-Reply-To: <1401190768-3932-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1401190768-3932-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5384846D.1000305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2014 13:39, Boris BREZILLON :
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Of course Boris, that will be good:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1066264..40c5580 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -808,6 +808,11 @@ F:	arch/arm/boot/dts/at91*.dtsi
>  F:	arch/arm/boot/dts/sama*.dts
>  F:	arch/arm/boot/dts/sama*.dtsi
>  
> +ARM/ATMEL AT91 Clock Support
> +M:	Boris Brezillon <boris.brezillon@free-electrons.com>
> +S:	Maintained
> +F:	drivers/clk/at91
> +
>  ARM/CALXEDA HIGHBANK ARCHITECTURE
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> 


-- 
Nicolas Ferre

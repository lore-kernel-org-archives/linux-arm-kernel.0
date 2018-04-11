From: joel@jms.id.au (Joel Stanley)
Date: Wed, 11 Apr 2018 13:36:17 +0930
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <20180222050324.21531-1-joel@jms.id.au>
References: <20180222050324.21531-1-joel@jms.id.au>
Message-ID: <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Arnd,

On 22 February 2018 at 15:33, Joel Stanley <joel@jms.id.au> wrote:
> I am interested in all ASPEED drivers, and the previous match wasn't
> grabbing files in nested directories. Use N instead.
>
> Add the arm kernel mailing list so that patches get reviewed there, and
> the linux-aspeed list which exists only so I can use patchwork to track
> patches.
>
> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
> stuff.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

can you please pick this one up? It would be great to get it into
fixes as Andrew and I have been missing being cc'd on stuff we would
have like to review.

Cheers,

Joel

> ---
>  MAINTAINERS | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a7f76eadae9..1ebf49797175 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1226,10 +1226,15 @@ F:      Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>
>  ARM/ASPEED MACHINE SUPPORT
>  M:     Joel Stanley <joel@jms.id.au>
> -S:     Maintained
> +R:     Andrew Jeffery <andrew@aj.id.au>
> +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:     linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
> +Q:     https://patchwork.ozlabs.org/project/linux-aspeed/list/
> +S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
>  F:     arch/arm/mach-aspeed/
>  F:     arch/arm/boot/dts/aspeed-*
> -F:     drivers/*/*aspeed*
> +N:     aspeed
>
>  ARM/ATMEL AT91 Clock Support
>  M:     Boris Brezillon <boris.brezillon@free-electrons.com>
> --
> 2.15.1
>

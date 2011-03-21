From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 16:37:59 +0000
Subject: [PATCH] ARM: Remove bouncing author email from
	arch/arm/plat-iop/time.c
In-Reply-To: <alpine.LNX.2.00.1103150236500.26293@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1103150236500.26293@swampdragon.chaosbits.net>
Message-ID: <20110321163759.GE4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deepak, are you happy with this?

On Tue, Mar 15, 2011 at 02:39:19AM +0100, Jesper Juhl wrote:
> Mr. Deepak Saxena's email address, listed at the head of 
> arch/arm/plat-iop/time.c, bounces. Remove it.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
> index 07f23bb..af6139d 100644
> --- a/arch/arm/plat-iop/time.c
> +++ b/arch/arm/plat-iop/time.c
> @@ -3,7 +3,7 @@
>   *
>   * Timer code for IOP32x and IOP33x based systems
>   *
> - * Author: Deepak Saxena <dsaxena@mvista.com>
> + * Author: Deepak Saxena
>   *
>   * Copyright 2002-2003 MontaVista Software Inc.
>   *
> 
> 
> -- 
> Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
> Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please.
> 

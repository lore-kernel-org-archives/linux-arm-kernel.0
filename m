From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 2 May 2010 14:20:49 +0200
Subject: [PATCH] arm: Fix .gitignore for boot/compressed folder
In-Reply-To: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Message-ID: <20100502122049.GA5553@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> This should complements changes done in:
I think this should read "complement" only, that is, no 's' at the end.
Other than that,

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
> 
>       arm: add support for LZO-compressed kernels
> 
> It missed to do the respective changes in '.gitignore' file.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/boot/compressed/.gitignore |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index ab204db..bb984af 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,5 @@
>  font.c
> -piggy.gz
> +piggy.gzip
> +piggy.lzo
> +lib1funcs.S
>  vmlinux.lds
> -- 
> 1.6.3.3
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

From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Apr 2015 09:40:32 +0900
Subject: [PATCH 1/6] Revert "staging: board: disable as it breaks the
 build"
In-Reply-To: <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20150406004031.GD1841@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 02:41:58PM +0200, Geert Uytterhoeven wrote:
> This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.
> 
> Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
> fixed the build of drivers/staging/board/board.c.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/staging/board/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
> index 0a89ad16371f7ded..b8ee81840666ad35 100644
> --- a/drivers/staging/board/Kconfig
> +++ b/drivers/staging/board/Kconfig
> @@ -1,7 +1,6 @@
>  config STAGING_BOARD
>  	bool "Staging Board Support"
>  	depends on OF_ADDRESS
> -	depends on BROKEN
>  	help
>  	  Select to enable per-board staging support code.
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

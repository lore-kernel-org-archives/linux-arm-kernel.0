From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 15:28:01 +0100
Subject: [PATH V2 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20140827142801.GA13850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:43:27PM +0100, Steve Capper wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 886db21..6a4d764 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
>  config HAVE_MEMBLOCK_PHYS_MAP
>  	boolean
>  
> +config HAVE_RCU_GUP
> +	boolean

Minor detail, maybe HAVE_GENERIC_RCU_GUP to avoid confusion.

Otherwise the patch looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

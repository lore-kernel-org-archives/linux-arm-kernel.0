From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 21 Jan 2010 10:26:19 +0100
Subject: [PATCH] ARM: MX3: Fixed typo in declared enum type name.
In-Reply-To: <1264065172-22494-1-git-send-email-vzapolskiy@gmail.com>
References: <1264065172-22494-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100121092619.GV8970@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 12:12:52PM +0300, Vladimir Zapolskiy wrote:
> To distinguish between mx31lite and mx31lilly boards better to use
> different enum types.

True, even though it shouldn't have any impact unless you include both
headers. I assume you didn't meet any real-life problem with that?

> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  arch/arm/plat-mxc/include/mach/board-mx31lite.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lite.h b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
> index 0184b63..2b2da03 100644
> --- a/arch/arm/plat-mxc/include/mach/board-mx31lite.h
> +++ b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
> @@ -25,7 +25,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -enum mx31lilly_boards {
> +enum mx31lite_boards {
>  	MX31LITE_NOBOARD	= 0,
>  	MX31LITE_DB		= 1,
>  };
> -- 
> 1.6.5.4
> 

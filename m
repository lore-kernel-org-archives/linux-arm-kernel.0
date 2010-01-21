From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jan 2010 14:37:38 +0100
Subject: [PATCH] ARM: MX3: Fixed typo in declared enum type name.
In-Reply-To: <1264065172-22494-1-git-send-email-vzapolskiy@gmail.com>
References: <1264065172-22494-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100121133738.GP7200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 12:12:52PM +0300, Vladimir Zapolskiy wrote:
> To distinguish between mx31lite and mx31lilly boards better to use
> different enum types.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>

Ok, scheduled for -rc.

Sascha


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
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

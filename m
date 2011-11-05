From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2011 17:14:29 -0700
Subject: [PATCH] ARM: OMAP: dmtimer: Include linux/module.h
In-Reply-To: <1320198586.9065.2.camel@phoenix>
References: <1320198586.9065.2.camel@phoenix>
Message-ID: <20111105001429.GK31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Lin <axel.lin@gmail.com> [111101 18:15]:
> Include linux/module.h to fix below build error:
...

> I got the build error by make omap2plus_defconfig on linux-next 20111101.
> 
>  arch/arm/plat-omap/dmtimer.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 2def4e1..af3b92b 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -35,6 +35,7 @@
>   * 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>

Thanks, applying into fixes.

Tony

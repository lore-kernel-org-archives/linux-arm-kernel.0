From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 31 Mar 2015 06:55:37 +0300
Subject: [PATCH] ARM: remove duplicate reboot.h include in process.c
In-Reply-To: <3093e9eafb72eae28fe83b350ddb88d2cd5c99d8.1427020607.git.baruch@tkos.co.il>
References: <3093e9eafb72eae28fe83b350ddb88d2cd5c99d8.1427020607.git.baruch@tkos.co.il>
Message-ID: <20150331035537.GL12479@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, all,

On Sun, Mar 22, 2015 at 12:36:47PM +0200, Baruch Siach wrote:
> Fixes: 7b6d864b48d ('reboot: arm: change reboot_mode to use enum reboot_mode')
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Unless anyone objects I'll put this trivial patch in the patch system 
tomorrow.

baruch

> ---
>  arch/arm/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index fdfa3a78ec8c..7989a9063fea 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -31,7 +31,6 @@
>  #include <linux/random.h>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/leds.h>
> -#include <linux/reboot.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/idmap.h>

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

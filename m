From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Aug 2012 10:13:58 +0800
Subject: [PATCH] ARM: mxs: remove duplicated include from mach-mxs.c
In-Reply-To: <CAPgLHd_QDRHKBybnCtD_K-JJvJG_f4x6wTXczQZqraiLch4wEg@mail.gmail.com>
References: <CAPgLHd_QDRHKBybnCtD_K-JJvJG_f4x6wTXczQZqraiLch4wEg@mail.gmail.com>
Message-ID: <CAAQ0ZWTLES1DtDEaYuhfHZOd-5UUje6xOj06O-GDcHBk4GSgUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2012 09:49, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Remove duplicated include.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for the patch.  But the duplicated inclusion has been fixed on
branch below, which is queued for 3.7.

 git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt-for-3.7

Regards,
Shawn

> ---
>  arch/arm/mach-mxs/mach-mxs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 8dabfe8..5c91870 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -14,7 +14,6 @@
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> -#include <linux/init.h>
>  #include <linux/irqdomain.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/mxsfb.h>
>

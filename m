From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 17 Jan 2013 15:02:39 +0530
Subject: [PATCH v2] ARM: spear3xx: Fix pl080-related build failure
In-Reply-To: <1358413763-21507-1-git-send-email-thierry.reding@avionic-design.de>
References: <1358413763-21507-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CAOh2x=m4NKbaVAzVNpLifS8rs1Yk=B=gYa-XYjNd3DgxhfZMjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 2:39 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Include linux/amba/pl080.h to pull in the various PL080_* macros.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/arm/mach-spear3xx/spear3xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> index f9d754f..7c218d9 100644
> --- a/arch/arm/mach-spear3xx/spear3xx.c
> +++ b/arch/arm/mach-spear3xx/spear3xx.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) "SPEAr3xx: " fmt
>
>  #include <linux/amba/pl022.h>
> +#include <linux/amba/pl080.h>
>  #include <linux/amba/pl08x.h>
>  #include <linux/io.h>
>  #include <plat/pl080.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

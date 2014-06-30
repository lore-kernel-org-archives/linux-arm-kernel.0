From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 14:16:30 +0200
Subject: [PATCH 01/16] ARM: mvebu: Sort the headers of pmsu.c in
 alphabetic order
In-Reply-To: <1403875377-940-2-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140630141630.684479f6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:42 +0200, Gregory CLEMENT wrote:
> Sorting the headers in alphabetic order will help to reduce the
> conflict when adding new headers later.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index a1d407c0febe..5584d35b8e88 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -19,13 +19,13 @@
>  #define pr_fmt(fmt) "mvebu-pmsu: " fmt
>  
>  #include <linux/cpu_pm.h>
> -#include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/of_address.h>
> +#include <linux/kernel.h>
>  #include <linux/io.h>

So, with your patch applied, if I'm correct, we will have:

#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/io.h>

It seems like we're not yet alphabetically sorted here :)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

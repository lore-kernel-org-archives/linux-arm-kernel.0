From: Barry.Song@csr.com (Barry Song)
Date: Wed, 14 Nov 2012 02:59:08 +0000
Subject: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
 linux/export.h
In-Reply-To: <1352821789-6640-1-git-send-email-s.syam@samsung.com>
References: <1352821789-6640-1-git-send-email-s.syam@samsung.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012296E17C@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Syam Sidhardhan [mailto:syamsidhardh at gmail.com]
> Sent: Tuesday, November 13, 2012 11:50 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Barry Song
> Subject: [PATCH 2/3] ARM: prima2: Replace include linux/module.h with
> linux/export.h
> 
> include <linux/export.h> is the right to go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>

Acked. Thanks!
> ---
>  arch/arm/mach-prima2/pm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
> index fb5a791..f4a2270 100644
> --- a/arch/arm/mach-prima2/pm.c
> +++ b/arch/arm/mach-prima2/pm.c
> @@ -9,7 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/suspend.h>
>  #include <linux/slab.h>
> -#include <linux/module.h>
> +#include <linux/export.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> --
> 1.7.4.1

-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 14:01:53 +0200
Subject: [PATCH 02/10] ARM: EXYNOS: Correct file path in comment message
In-Reply-To: <1396425058-4012-3-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <533BFC31.1080203@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2014 09:50 AM, Pankaj Dubey wrote:
> This patch corrects file path mentioned in file comment message.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 03e5e9f..d8d1555 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -1,4 +1,4 @@
> -/* linux/arch/arm/mach-exynos4/platsmp.c
> +/* linux/arch/arm/mach-exynos/platsmp.c
>   *
>   * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com
> 

Shouldn't you just remove it entirely?
I had the same file names in the whole microblaze tree
and some months/years later this was just broken everywhere.
That's why it is just easier to remove it entirely.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/4f7d22f3/attachment.sig>

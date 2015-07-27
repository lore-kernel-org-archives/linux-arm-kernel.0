From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 27 Jul 2015 16:13:33 +0200
Subject: [PATCH 18/18] iommu: tegra-smmu: remove cacheflush.h
In-Reply-To: <E1ZJhXt-0004Ck-LR@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
 <E1ZJhXt-0004Ck-LR@rmk-PC.arm.linux.org.uk>
Message-ID: <20150727141331.GD16858@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 01:30:17PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/iommu/tegra-smmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e5d6bc45c58f..4a8b66f05d8f 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -16,8 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -#include <asm/cacheflush.h>
> -

Doesn't this logically belong in patch 13/18, along with the DMA API
conversion that drops the last reference to these functions?

Again, I can take care of squashing this into 13/18 if you don't have
any objections and send a pull request to Joerg.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/17e208af/attachment.sig>

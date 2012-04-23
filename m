From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Apr 2012 15:09:35 +0300
Subject: [PATCH 2/3] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1335181043-15348-2-git-send-email-hdoyu@nvidia.com>
References: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
 <1335181043-15348-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120423120934.GZ26302@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 23, 2012 at 02:37:22PM +0300, Hiroshi DOYU wrote:
> diff --git a/arch/arm/mach-tegra/tegra-ahb.c b/arch/arm/mach-tegra/tegra-ahb.c
> index 411b51f..40877fa 100644
> --- a/arch/arm/mach-tegra/tegra-ahb.c
> +++ b/arch/arm/mach-tegra/tegra-ahb.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>

EXPORT_SYMBOL() is defined in <linux/export.h>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/e5b0e8eb/attachment.sig>

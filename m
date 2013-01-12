From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 12 Jan 2013 07:25:56 +0100
Subject: [PATCH 3/4] ARM: imx: restore uncompress.h to a common place
In-Reply-To: <1355319945-3199-4-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <1355319945-3199-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <50F101F4.8080009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.12.2012 14:45, Shawn Guo wrote:
> Restore arch/arm/plat-mxc/include/mach/uncompress.h removed by commit
> 3995eb8 (ARM: imx: merge plat-mxc into mach-imx) to a common place as
> arch/arm/include/debug/uncompress/imx.h.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
...
> +++ b/arch/arm/include/debug/uncompress/imx.h
...
> + *  arch/arm/plat-mxc/include/mach/uncompress.h

In case you touch these patches again, you might check if the above 
path and file name in the file header should be adapted to the new 
file location, too.

Best regards

Dirk

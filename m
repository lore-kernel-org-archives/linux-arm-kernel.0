From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 14:14:19 +0800
Subject: [PATCH] ARM: configs: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1398504922-9223-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1398504922-9223-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <20140429061417.GJ16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 03:05:22PM +0530, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> this patch removes COMMON_CLK_DEBUG config option
> from defconfig file as this config option is obsolete.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  arch/arm/configs/imx_v4_v5_defconfig    |    1 -
>  arch/arm/configs/imx_v6_v7_defconfig    |    1 -
...
>  arch/arm/configs/mxs_defconfig          |    1 -

Please drop these 3 files from your patch.  The obsolete
COMMON_CLK_DEBUG option has been removed from two of them on my branch
by savedefconfig, and we will address the remaining one in another
patch.

Shawn

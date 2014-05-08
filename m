From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 May 2014 15:31:20 -0400
Subject: [PATCH v2] ARM: configs: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1398755224-7530-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1398755224-7530-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <536BDB88.8090106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 03:07 AM, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> this patch removes COMMON_CLK_DEBUG config option
> from defconfig file as this config option is obsolete.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  Changes for v2:
>  a> Dropped imx defconfig files as suggested by Shawn.
>  

>  arch/arm/configs/keystone_defconfig     |    1 -
Am picking the keystone part from this patch. Thanks.
You might want split this patch so that others can pick it
up

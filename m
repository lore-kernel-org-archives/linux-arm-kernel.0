From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 20:59:08 +0900
Subject: [PATCH 340/493] arm: remove use of __devinitdata
In-Reply-To: <1353349642-3677-340-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-340-git-send-email-wfp5p@virginia.edu>
Message-ID: <0e5901cdc7df$9d088c70$d719a550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Pemberton wrote:
> 
> CONFIG_HOTPLUG is going away as an option so __devinitdata is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> ---

[...]

>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |  2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c        | 68
++++++++++++++-----------
> ---

For above s3c64xx,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

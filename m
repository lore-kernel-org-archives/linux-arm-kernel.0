From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 20:59:23 +0900
Subject: [PATCH 484/493] arm: remove use of __devexit
In-Reply-To: <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
Message-ID: <0e5a01cdc7df$a5ad12b0$f1073810$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Pemberton wrote:
> 
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-omap at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---

[...]

>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c  | 2 +-
>  arch/arm/plat-samsung/adc.c              | 2 +-

For above s3c24xx and samsung,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd

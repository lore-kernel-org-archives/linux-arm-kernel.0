From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 20:58:50 +0900
Subject: [PATCH 270/493] arm: remove use of __devinit
In-Reply-To: <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Message-ID: <0e5801cdc7df$91fe9ef0$b5fbdcd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Pemberton wrote:
> 
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-tegra at vger.kernel.org
> ---

[...]

>  arch/arm/mach-s3c24xx/h1940-bluetooth.c      |  2 +-
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c      |  2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |  2 +-

For above s3c24xx and s3c64xx,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

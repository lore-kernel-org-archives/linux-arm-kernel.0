From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Nov 2012 18:53:50 +0800
Subject: [PATCH 270/493] arm: remove use of __devinit
In-Reply-To: <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAGsJ_4y2+o7HBH-TQWaanUs9ZgZHhXg3YpEUzd5-VoeZ9+wiMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/20 Bill Pemberton <wfp5p@virginia.edu>:
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

Acked-by: Barry Song <baohua.song@csr.com>

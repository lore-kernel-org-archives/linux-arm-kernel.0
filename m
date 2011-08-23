From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Aug 2011 10:50:21 +0900
Subject: [PATCH 1/4] ARM: SAMSUNG: Add support for detecting CPU at	runtime
In-Reply-To: <20110820080759.GA18827@n2100.arm.linux.org.uk>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
	<1313816759-14564-2-git-send-email-kgene.kim@samsung.com>
	<20110820080759.GA18827@n2100.arm.linux.org.uk>
Message-ID: <06bd01cc6137$058b1bc0$10a15340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Sat, Aug 20, 2011 at 02:05:56PM +0900, Kukjin Kim wrote:
> > The cpu_is_[name]() can be used to distinguish cpu at runtime.
> 
> This really should be soc_is_xxx().  The CPU is stuff like ARM920, ARM926,
> Cortex-A9 etc.  The SoC is the CPU plus the peripherals.
> 
> S3C6410 describes the entire SoC, not just the CPU.

OK and will address comments from you.

Russell, I'm not sure it is required to change CPU_XXX such as
CPU_EXYNOS4210 to SOC_XXX in Kconfig.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

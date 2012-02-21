From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Feb 2012 19:35:40 +0900
Subject: [PATCH v2 04/11] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <CAOesGMhmcnt6LPb9O+3420VgG=PiCnOjzZA3JqsA=4OdHN-R-g@mail.gmail.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
 <CAOesGMhmcnt6LPb9O+3420VgG=PiCnOjzZA3JqsA=4OdHN-R-g@mail.gmail.com>
Message-ID: <00a901ccf084$90460900$b0d21b00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi Olof,

[snip]

> > +#ifdef CONFIG_ARCH_EXYNOS4
> > +
> 
> irqs.h seems to be one of the major files that causes conflicts if a
> combined EXYNOS4+5 kernel is built (after editing Kconfig to allow
> both). Can you please try to come up with a way to allow both of them
> to coexist instead of making them exclusive?
> 
Yes, as you said, it brakes single zImage for EXYNOS4 + EXYNOS5
(mach-exynos). So I'm working on regarding resource for EXYNOS SoCs and I
think, it can resolve the problem you said before v3.4 merge window.

If any updates, let you know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

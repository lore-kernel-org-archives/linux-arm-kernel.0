From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jul 2012 18:11:00 +0900
Subject: [PATCH 0/2] Exynos4: power domain fixes for v3.5-rc
In-Reply-To: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
References: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <0fad01cd600e$41940240$c4bc06c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> This is a resend of my power domain fixes for Samsung Exynos platform.
> They fix issues introduced by switching to gen_pd based driver in commit
> 91cfbd4ee0 ('ARM: EXYNOS: Hook up power domains to generic power domain
> infrastructure') and restore runtime pm functionality for multimedia
> drivers (s5p-fimc, s5p-mfc, s5p-tv, exynos-drm). Tested on Universal
> C210 and NURI boards, but the issues were also reported for Origen
> boards and others. If possible, please consider these patches as fixes
> (runtime pm is broken without them) and merge to v3.5-rc line.
> 
> Best regards
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 
> Patch summary:
> 
> Marek Szyprowski (2):
>   ARM: Exynos4: read initial state of power domain from hw registers
>   ARM: Exynos4: pm_domains: register devices in 'need_restore' state
> 
>  arch/arm/mach-exynos/pm_domains.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> --
> 1.7.1.569.g6f426

OK, applied this series in my -fixes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

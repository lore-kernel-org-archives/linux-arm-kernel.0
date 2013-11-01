From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 01 Nov 2013 18:08:59 +0100
Subject: [PATCH v2 1/4] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <1381763305-7085-2-git-send-email-v.tyrtov@samsung.com>
References: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
 <1381763305-7085-2-git-send-email-v.tyrtov@samsung.com>
Message-ID: <8049244.xSqsotZorc@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 of October 2013 19:08:22 Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> EXYNOS5410 is SoC in Samsung's Exynos5 SoC series.
> Add initial support for this SoC.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig             | 12 ++++++++++++
>  arch/arm/mach-exynos/common.c            | 18 ++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/map.h  |  1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c   |  1 +
>  arch/arm/plat-samsung/include/plat/cpu.h |  8 ++++++++
>  5 files changed, 40 insertions(+)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

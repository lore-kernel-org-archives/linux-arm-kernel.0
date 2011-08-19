From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 15:51:11 +0900
Subject: [PATCH] ARM:EXYNOS4: Add the missing clock of EXYNOS4210 to remove
	leakage power
In-Reply-To: <4E425573.30408@samsung.com>
References: <4E425573.30408@samsung.com>
Message-ID: <002701cc5e3c$61a16e80$24e44b80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
> Singed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Singed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c                 |  295
> +++++++++++++++++++++++++
>  arch/arm/mach-exynos4/include/mach/regs-pmu.h |    6 +
>  2 files changed, 301 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-exynos4/clock.c
> 
NO. don't change the mode :(

And I don't think we _really_ need to add all clocks if they will not be used anywhere in kernel. If it is required, please turn off the clocks in boot loader.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

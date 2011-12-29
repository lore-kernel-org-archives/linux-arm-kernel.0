From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 12:30:20 +0900
Subject: [PATCH V1] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <1324966676-5714-1-git-send-email-riverful.kim@samsung.com>
References: <1324966676-5714-1-git-send-email-riverful.kim@samsung.com>
Message-ID: <028701ccc5da$31491fc0$93db5f40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HeungJun, Kim wrote:
> 
> This patch adds Samsung Mobile TRATS board support.
> 
> The changes against V0:
>   1) Modify Makefile & boardfile name: from "board-trats.c" to "mach-
> trats.c"
>   2) Fix name of mmc's fixed regulator: remove "inverted"
>   3) Fix directory name on GPL comments: from "exynos4" to "exynos"
> 
> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig      |   11 ++
>  arch/arm/mach-exynos/Makefile     |    1 +
>  arch/arm/mach-exynos/mach-trats.c |  340
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 352 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/mach-trats.c
> 
Hi HeungJun,

Thanks for your re-submit.

Hmm, maybe this is v2 not v1?

Anyway, as I said, this conflicts with other ARM consolidation works. So
please wait until after the merge window for this patch.

Happy New Year.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

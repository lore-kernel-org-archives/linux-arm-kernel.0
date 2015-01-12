From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 12 Jan 2015 17:44:57 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Add exynos3250 suspend-to-ram support
In-Reply-To: <1420681838-4292-1-git-send-email-cw00.choi@samsung.com>
References: <1420681838-4292-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <54B38989.4030700@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/15 10:50, Chanwoo Choi wrote:
> This patch adds the support for suspend-to-ram feature of Exynos3250 SoC.
> Exynos3250 don't contain the L2 cache.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Depend on:
> - v3.19-rc3
> 
Chanwoo,

Can you please let me know why this is depending on v3.19-rc3?
If I apply this on top of my tree not including some stuff between
v3.19-rc1 and v3.19-rc3, is there a problem?

>  arch/arm/mach-exynos/regs-pmu.h |  3 ++
>  arch/arm/mach-exynos/suspend.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

[...]

Thanks,
Kukjin

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Dec 2011 00:57:47 +0900
Subject: [PATCH v5 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
 maintainable
In-Reply-To: <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
Message-ID: <4EEE0D7B.5080805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/11 01:35, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.
>
> Signed-off-by: Dave Martin<dave.martin@linaro.org>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>          (for nomadik, ux500)
> Acked-by: Tony Lindgren<tony@atomide.com>
>          (for omap)

for exynos:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>   arch/arm/Kconfig               |   18 ++++++++++++++----
>   arch/arm/mach-exynos/Kconfig   |    1 +
>   arch/arm/mach-imx/Kconfig      |    1 +
>   arch/arm/mach-msm/Kconfig      |    1 +
>   arch/arm/mach-omap2/Kconfig    |    1 +
>   arch/arm/mach-realview/Kconfig |    4 ++++
>   arch/arm/mach-vexpress/Kconfig |    1 +
>   7 files changed, 23 insertions(+), 4 deletions(-)

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

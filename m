From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 9 Jun 2014 10:19:20 +0530
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Message-ID: <CAOh2x=ms6Z421AqGAQxJFA3v63fDGu+=+zfrVzNzrfQOZoZGjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 4:06 PM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Since the OPP layer is a kernel library which has been converted to be
> directly selectable by its callers rather than user selectable and
> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
> has become redundant and can be removed. Do so.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  Documentation/power/opp.txt    | 3 ---
>  arch/arm/mach-exynos/Kconfig   | 1 -
>  arch/arm/mach-highbank/Kconfig | 1 -
>  arch/arm/mach-imx/Kconfig      | 1 -
>  arch/arm/mach-omap2/Kconfig    | 1 -
>  arch/arm/mach-shmobile/Kconfig | 2 --
>  arch/arm/mach-vexpress/Kconfig | 1 -
>  arch/arm/mach-zynq/Kconfig     | 1 -
>  drivers/devfreq/Kconfig        | 1 -
>  kernel/power/Kconfig           | 3 ---
>  10 files changed, 15 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

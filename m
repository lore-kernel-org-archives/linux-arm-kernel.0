From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 28 Mar 2015 08:51:55 +0530
Subject: [PATCH] cpufreq: exynos: remove dead ->need_apll_change method
In-Reply-To: <2557080.JPtuM0lETZ@amdc1032>
References: <2557080.JPtuM0lETZ@amdc1032>
Message-ID: <CAKohpokU=1XM2BHsF-vLizAbLqdkCb5ZwHmeP_O4kD6xnuLyQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2015 at 22:02, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Commit 26ab1c62b6e1 ("cpufreq: exynos5250: Set APLL rate
> using CCF API") removed the last user of ->need_apll_change
> method.  Remove it and then cleanup exynos_cpufreq_scale()
> accordingly.
>
> This patch was tested on Exynos4412 SoC based Trats2 board.
>
> There should be no functional changes caused by this patch.
>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |   30 +++---------------------------
>  drivers/cpufreq/exynos-cpufreq.h |    1 -
>  2 files changed, 3 insertions(+), 28 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Kukjin: please take it through your tree.

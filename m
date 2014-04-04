From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:33:20 +0530
Subject: [PATCH 12/17] ARM: exynos: cpuidle: Move S5P_CHECK_AFTR in a
 header
In-Reply-To: <1396597683-6969-13-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-13-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpom35cbzoJL7VZf-mMRaG2GhCcC8N1Oc2RzbWWH19Fn+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Move the S5P_CHECK_AFTR definition to the header it belongs to.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c  |    2 --
>  arch/arm/mach-exynos/regs-pmu.h |    1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

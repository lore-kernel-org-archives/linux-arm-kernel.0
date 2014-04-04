From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:39:56 +0530
Subject: [PATCH 15/17] ARM: exynos: cpuidle: Pass the AFTR callback to the
 platform_data
In-Reply-To: <1396597683-6969-16-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-16-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpon0ti43Rt8wTp4xi2zR_9ryK9oSq5KKHc-8gkEkZc0pQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> No more dependency on the arch code. The platform_data field is used to set the
> PM callback as the other cpuidle driver.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c  |    5 +++--
>  arch/arm/mach-exynos/common.h  |    1 +
>  arch/arm/mach-exynos/cpuidle.c |    8 ++++----
>  arch/arm/mach-exynos/pmu.c     |    6 ++++++
>  4 files changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

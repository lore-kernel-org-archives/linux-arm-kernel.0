From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:15:10 +0530
Subject: [PATCH 03/17] ARM: exynos: cpuidle: change function name prefix
In-Reply-To: <1396597683-6969-4-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpomM9rggGtZ+aw2nWpbBkoGzS82S2uLorNh1+a_CKnMZTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> The driver was initially written for exynos4 but the driver is used also for
> exynos5.
>
> Change the function prefix name exynos4 -> exynos
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

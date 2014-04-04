From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:14:28 +0530
Subject: [PATCH 02/17] ARM: exynos: cpuidle: use cpuidle_register
In-Reply-To: <1396597683-6969-3-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpok84nOvudG3Grs=YVcAczX6wUYX6YcWDECagKP6tRdnoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Use the cpuidle generic function 'cpuidle_register'. That saves us from some
> extra lines of code and unneeded variables.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

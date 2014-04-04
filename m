From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:37:19 +0530
Subject: [PATCH 16/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle directory
In-Reply-To: <1396597683-6969-17-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-17-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpo=GFWgVgroFzBJEpCV6H1dkdirFzmO8tTpuM5U8mXgmAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

Maybe a few lines here on why this is important..

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/Makefile                      |    1 -
>  drivers/cpuidle/Kconfig.arm                        |    7 +++++++
>  drivers/cpuidle/Makefile                           |    1 +
>  .../cpuidle.c => drivers/cpuidle/cpuidle-exynos.c  |    0
>  4 files changed, 8 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/cpuidle-exynos.c (100%)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

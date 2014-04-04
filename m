From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:35:47 +0530
Subject: [PATCH 14/17] ARM: exynos: cpuidle: Move the boot vector in pm.c
In-Reply-To: <1396597683-6969-15-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-15-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpoktFrLgvnPSYNhkJf23KFxbVSr-gH1Zp+SMod8Uo1ntdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> As usual, move the boot vector setting in the pm.c file and use the cpu_pm
> notifier to set it up.
>
> Remove the unused headers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   22 ----------------------
>  arch/arm/mach-exynos/pm.c      |   15 +++++++++++++++
>  2 files changed, 15 insertions(+), 22 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:16:12 +0530
Subject: [PATCH 04/17] ARM: exynos: cpuidle: encapsulate register access
 inside a function
In-Reply-To: <1396597683-6969-5-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpomCX1qg-E5XD5X5Cr0vBH8zPrDQDwd2yFnuta-D6JT_uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> That makes the code cleaner and encapsulted. The function will be reused in the
> next patch.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/pm.c |   65 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 24 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

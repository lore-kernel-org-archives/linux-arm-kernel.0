From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:40:27 +0530
Subject: [PATCH 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <1396597683-6969-18-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-18-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpo=Dbp1uSCpOMhAx5vk9ddYP=DK14Od6_aoAuyX3mrwzew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:18, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> The cpuidle driver is broken since v3.11 and now we are at v3.14.
>
> Default the cpuidle driver to favorize a better detection next time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

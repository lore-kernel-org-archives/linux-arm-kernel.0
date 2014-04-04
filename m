From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:30:19 +0200
Subject: [PATCH V2 07/17] ARM: exynos: cpuidle: Use the cpu_pm notifier
In-Reply-To: <1396618989-2897-8-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <6920211.mKt6dNeJi7@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:42:59 PM Daniel Lezcano wrote:
> Use the cpu_pm_enter/exit notifier to group some pm code inside the pm file.
> 
> The save and restore code is duplicated across pm.c and cpuidle.c. By using
> the cpu_pm notifier, we can factor out the routine.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for fixing Exynos5250 support in V2.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

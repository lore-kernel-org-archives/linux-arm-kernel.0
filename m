From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:31:39 +0200
Subject: [PATCH V2 10/17] ARM: exynos: cpuidle: Move exynos_set_wakeupmask
 in the cpu_pm notifier
In-Reply-To: <1396618989-2897-11-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-11-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <2816335.y4e3er9YEb@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:43:02 PM Daniel Lezcano wrote:
> Let's encapsulate more the PM code inside the PM file by moving the
> 'exynos_set_wakeupmask' function inside the pm.c and the call in the cpu_pm
> notifier.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

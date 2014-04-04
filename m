From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:31:52 +0200
Subject: [PATCH V2 11/17] ARM: exynos: cpuidle: Move the power sequence
 call in the cpu_pm notifier
In-Reply-To: <1396618989-2897-12-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-12-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1453504.t68tBsSbiF@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:43:03 PM Daniel Lezcano wrote:
> The code to initiate and exit the powerdown sequence is the same in pm.c and
> cpuidle.c.
> 
> Let's split the common part in the pm.c and reuse it from the cpu_pm notifier.
> 
> That is one more step forward to make the cpuidle driver arch indenpendant.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

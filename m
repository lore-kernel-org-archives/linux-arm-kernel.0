From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:29:23 +0200
Subject: [PATCH V2 06/17] ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
In-Reply-To: <1396618989-2897-7-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-7-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <2096980.m4SU8Yq1z8@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:42:58 PM Daniel Lezcano wrote:
> This function should be called only when the powerdown sequence fails.
> 
> Even if the current code does not hurt, by moving this line, we have the same
> code than the one in pm.c.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

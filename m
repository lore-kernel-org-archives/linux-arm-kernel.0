From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:35:14 +0200
Subject: [PATCH V2 13/17] ARM: exynos: cpuidle: Move clock setup to pm.c
In-Reply-To: <1396618989-2897-14-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-14-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1760778.bkYYS0bViq@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:43:05 PM Daniel Lezcano wrote:
> One more step is moving the clock ratio setting at idle time in pm.c
> 
> The macro names have been changed to be consistent with the other macros
> name in the file.
> 
> Note, the clock divider was working only when cpuidle was enabled because it
> was in its init routine. With this change, the clock divider is set in the pm's
> init routine, so it will also operate when the cpuidle driver is not set, which
> is good.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

There was the earlier patch which was moving this code to clock driver
however it fell through cracks.  Either way is fine with me so..

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

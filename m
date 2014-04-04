From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:31:03 +0200
Subject: [PATCH V2 09/17] ARM: exynos: cpuidle: Remove ifdef for scu_enable
In-Reply-To: <1396618989-2897-10-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-10-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1556307.MbJMSDe5D6@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:43:01 PM Daniel Lezcano wrote:
> The scu_enable function is already a noop in the scu's header file is
> CONFIG_SMP=n, so no need to use these macros in the code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

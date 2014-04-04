From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:35:44 +0200
Subject: [PATCH V2 15/17] ARM: exynos: cpuidle: Pass the AFTR callback to
 the platform_data
In-Reply-To: <1396618989-2897-16-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-16-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5140877.BSLNpO7aM0@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:43:07 PM Daniel Lezcano wrote:
> No more dependency on the arch code. The platform_data field is used to set the
> PM callback as the other cpuidle drivers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

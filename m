From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:29:08 +0200
Subject: [PATCH V2 05/17] ARM: exynos: cpuidle: Move some code inside the
 idle_finisher
In-Reply-To: <1396618989-2897-6-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5398599.7JJndGtXvQ@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:42:57 PM Daniel Lezcano wrote:
> Move the code around to differentiate different section of code and prepare it
> to be factored out in the next patches.
> 
> The call order changed but hat doesn't have a side effect because they are
> independent. The important call is cpu_do_idle() which must be done the last.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

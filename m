From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 14:03:39 +0530
Subject: [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
In-Reply-To: <1436456621-29839-2-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150727083339.GB31611@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> +bool dev_pm_opp_get_turbo_mode_setting(struct dev_pm_opp *opp)

This should be named dev_pm_opp_is_turbo().

-- 
viresh

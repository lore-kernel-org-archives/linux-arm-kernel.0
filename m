From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 15 Dec 2014 17:17:58 +0100
Subject: [PATCH] clocksource: sirf: Remove unused variable
In-Reply-To: <1418659160-2115-1-git-send-email-thierry.reding@gmail.com>
References: <1418659160-2115-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <548F09B6.6010202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2014 04:59 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Commit ef89af1f4380 ("clocksource: sirf: Remove hard-coded clock rate")
> removes all uses of the timer_div variable. Since the variable is no
> longer used it should be removed.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Applied to my tree. Thanks!

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

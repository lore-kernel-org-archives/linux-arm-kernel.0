From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Dec 2017 14:15:58 +0100
Subject: [PATCH v2 3/8] clocksource: owl: Adopt TIMER_OF_DECLARE()
In-Reply-To: <20171113233427.5386-4-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
 <20171113233427.5386-4-afaerber@suse.de>
Message-ID: <ea505d67-79da-9e59-07e9-047cecd6695c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 00:34, Andreas F?rber wrote:
> Commit 1727339590fdb5a1ded881b540cd32121278d414 ("clocksource/drivers:
> Rename CLOCKSOURCE_OF_DECLARE to TIMER_OF_DECLARE") deprecated
> CLOCKSOURCE_OF_DECLARE(), so adopt the new macro TIMER_OF_DECLARE().
> 
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

Applied for 4.16


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 Sep 2016 21:55:26 +0200
Subject: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
In-Reply-To: <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <c29cd7d6-bc45-1207-0133-271a35ad2c4d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2016 21:12, Robert Jarzmik wrote:
> The OS timer rate used for the watchdog can now be fetched from the
> standard clock API. This will remove the last user of
> get_clock_tick_rate() in both pxa and sa11x0 architectures.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

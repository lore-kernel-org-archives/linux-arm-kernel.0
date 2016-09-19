From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 Sep 2016 21:58:12 +0200
Subject: [PATCH 4/4] ARM: sa11x0/pxa: get rid of get_clock_tick_rate
In-Reply-To: <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <06a58a7f-63c1-b0a0-2b94-5805cc97b811@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2016 21:12, Robert Jarzmik wrote:
> The last user of this function is gone, so remove it. The clock API
> should now be used to get clock rates.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

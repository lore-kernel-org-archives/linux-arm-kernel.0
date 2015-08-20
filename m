From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 20 Aug 2015 21:03:04 +0200
Subject: [PATCH] clocksource: arm_global_timer: register delay timer
In-Reply-To: <1439991818-31989-1-git-send-email-rabin.vincent@axis.com>
References: <1439991818-31989-1-git-send-email-rabin.vincent@axis.com>
Message-ID: <55D62468.4050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2015 03:43 PM, Rabin Vincent wrote:
> Provide a delay timer using the lower 32-bits of the global timer so
> that we can use that instead of having to calibrating delays.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Applied to my tree for 4.4

Thanks !

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

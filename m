From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Feb 2014 13:58:01 +0100
Subject: [PATCH v6 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <1392027058-11680-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1392027058-11680-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1392027058-11680-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52FA1E59.1000307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 11:10 AM, Ivan Khoronzhuk wrote:
> Add broadcast clock-event device for the Keystone arch.
>
> The timer can be configured as a general-purpose 64-bit timer,
> dual general-purpose 32-bit timers. When configured as dual 32-bit
> timers, each half can operate in conjunction (chain mode) or
> independently (unchained mode) of each other.
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Santosh shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---

Applied to my tree for 3.15

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

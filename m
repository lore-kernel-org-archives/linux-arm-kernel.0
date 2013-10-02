From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 02 Oct 2013 12:23:38 +0200
Subject: [PATCH] clocksource: arm_arch_timer: Use clocksource for suspend
 timekeeping
In-Reply-To: <1380312792-7275-1-git-send-email-sboyd@codeaurora.org>
References: <1380312792-7275-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <524BF42A.7020509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 10:13 PM, Stephen Boyd wrote:
> The ARM architected timers keep counting during suspend so we can
> mark this clocksource with the CLOCK_SOURCE_SUSPEND_NONSTOP flag.
> This flag will indicate that this clocksource can be used for
> calculating suspend time and injecting sleep time into the
> timekeeping core. This should be more accurate than using an
> external RTC or architecture specific persistent clock.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to my tree for 3.13

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 16:40:23 +0200
Subject: [PATCH] clocksource/drivers/armada-370-xp: make syscore_ops static
In-Reply-To: <1465309073-20584-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465309073-20584-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5762BA57.10903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 04:17 PM, Ben Dooks wrote:
> The driver does not export armada_370_xp_timer_syscore_ops so
> make it static to fix the following warning:
>
> drivers/clocksource/time-armada-370-xp.c:249:20: warning: symbol 'armada_370_xp_timer_syscore_ops' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---

Applied, thanks.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

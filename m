From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Oct 2014 14:33:01 +0200
Subject: [PATCH] ARM: integrator: move AP timer to clocksource
In-Reply-To: <1413444463-15823-1-git-send-email-linus.walleij@linaro.org>
References: <1413444463-15823-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <543FBAFD.7060205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2014 09:27 AM, Linus Walleij wrote:
> This moves the timer/clocksource implementation for the
> Integrator/AP down to drivers/clocksource and augments the
> driver a little to use CLOCKSOURCE_OF_DECLARE(). Remove
> the static mapping of the timer blocks while we're at it.
>
> Tested on the Integrator/AP.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Daniel, Thomas: can you ACK this to be taken through ARM SoC?

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

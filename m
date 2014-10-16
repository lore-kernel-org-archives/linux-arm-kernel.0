From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Oct 2014 14:08:56 +0200 (CEST)
Subject: [PATCH] ARM: integrator: move AP timer to clocksource
In-Reply-To: <1413444463-15823-1-git-send-email-linus.walleij@linaro.org>
References: <1413444463-15823-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.11.1410161408350.17020@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Oct 2014, Linus Walleij wrote:

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

Acked-by-me

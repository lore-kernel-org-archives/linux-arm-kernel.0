From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Mar 2014 13:19:00 +0100
Subject: [PATCH 2/3] ARM/leds: move ARM Versatile LED driver to leds
 subsystem
In-Reply-To: <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
 <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZo0jpr9sCkYDbtYiK8rFrgqt36OhyMR-iLjEmAtLGnAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 2:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Now that we have converted this driver to a real platform device
> module-based thing, we move the driver down into the LEDs
> subsystem and rename the config option to LEDS_VERSATILE.
>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Bryan: can you provide an ACK for this patch so I can funnel
> this through the ARM SoC tree?

Ping on this.

Yours,
Linus Walleij

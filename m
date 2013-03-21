From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 19:15:38 +0100
Subject: [PATCH 10/11] ARM: move sp804 and integrator timers to
 drivers/clocksource
In-Reply-To: <1363820051-24428-11-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-11-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdYvY9BRAikAyyFHvg8uaWK7msOhVSDFG_zRZQJhG1cuAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 11:54 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Move timer-sp and integrator-ap timer code to drivers/clocksource and
> update timer-sp.h and arm_timer.h includes.
>
> This adds CLKSRC_OF support for the integrator-ap timer and removes the
> use of "arm,timer-primary" and "arm,timer-secondary" aliases. The timer
> selection should not be important as all 3 timers are equal capability.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Nice!

This looks like it'll work.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

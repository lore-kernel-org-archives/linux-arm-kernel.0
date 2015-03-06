From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Mar 2015 09:57:12 +0100
Subject: [PATCH 07/14] clockevent: Add STM32 Timer driver
In-Reply-To: <1423763164-5606-8-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-8-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdZ4MeAR14W+Jr6GYY+oeVJZgKEu+Sr=OXriUPAC43ur-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
> The drivers detects whether the time is 16 or 32 bits, and applies a
> 1024 prescaler value if it is 16 bits.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

This is a nice driver.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

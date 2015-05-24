From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 24 May 2015 23:07:55 +0200
Subject: [PATCH v9 2/5] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <1432328616-16964-3-git-send-email-mcoquelin.stm32@gmail.com>
References: <1432328616-16964-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1432328616-16964-3-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <55623DAB.2000402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2015 11:03 PM, Maxime Coquelin wrote:
> STM32 MCUs feature 16 and 32 bits general purpose timers with prescalers.
> The drivers detects whether the time is 16 or 32 bits, and applies a
> 1024 prescaler value if it is 16 bits.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Applied to my tree for 4.2

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 10:38:25 +0200
Subject: [PATCH] drivers/clocksource/fttmr010: Factor clock read code
In-Reply-To: <20170613214813.11406-1-linus.walleij@linaro.org>
References: <20170613214813.11406-1-linus.walleij@linaro.org>
Message-ID: <18eafd32-2b61-f79e-e57c-bf7ab862c7c8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2017 23:48, Linus Walleij wrote:
> The sched_clock() and delay timer callbacks can just call
> each other and we can save an #ifdef.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Daniel: feel free to apply as-is or squash into the other
> patch as you like.
> ---
>  drivers/clocksource/timer-fttmr010.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
Applied thanks!

 -- Daniel

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 17:00:17 +0200
Subject: [PATCH 2/7] gpiolib: Support purely name based gpiod lookup in
 device trees
In-Reply-To: <1397544101-18135-3-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-3-git-send-email-wens@csie.org>
Message-ID: <CACRpkdZ+3dnhoj1TS4KSVUP8iFHsjjwop-FG2Nf07YtH6aSO_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:41 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> This patch enables gpio-names based gpiod lookup in device tree usage,
> which ignores the index passed to gpiod_get_index. If this fails, fall
> back to the original function-index ("con_id"-gpios) based lookup scheme,
> for backward compatibility and any drivers needing more than one GPIO
> for any function.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This looks a bit scary and I cannot claim to realize the entire semantic
effect of this patch, but if it's the way to go then OK.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I just apply this to the GPIO tree or are you carrying it along with
the other stuff?

Yours,
Linus Walleij

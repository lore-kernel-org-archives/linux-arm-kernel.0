From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 7 Nov 2012 10:44:58 +0530
Subject: [PATCH 4/5] gpiolib: call pin removal in chip removal function
In-Reply-To: <1352215021-30341-1-git-send-email-linus.walleij@stericsson.com>
References: <1352215021-30341-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x==PKDrOGrdxVTsqt6gr3K-0WPv800SYu3Ob=dNjnCW+NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2012 at 8:47 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This makes us call gpiochio_remove_pin_ranges() in the
> gpiochip_remove() function, so we get rid of ranges when
> freeing the chip.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

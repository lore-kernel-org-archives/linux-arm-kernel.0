From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 7 Nov 2012 10:44:20 +0530
Subject: [PATCH 3/5] gpiolib: remove duplicate pin range code
In-Reply-To: <1352215014-30305-1-git-send-email-linus.walleij@stericsson.com>
References: <1352215014-30305-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x=nT8_95uu9tfEnOHy9Gkm6gEEAVAKKwPAqbLJz3bwFDNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2012 at 8:46 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Commit 69e1601bca88809dc118abd1becb02c15a02ec71
> "gpiolib: provide provision to register pin ranges"
>
> Introduced both of_gpiochip_remove_pin_range() and
> gpiochip_remove_pin_ranges(). But the contents are exactly
> the same so remove the OF one and rely on the range deletion
> in the core.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I can't believe that i did this :(

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

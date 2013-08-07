From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 21:57:45 +0200
Subject: [PATCH] pinctrl: sunxi: Fix gpio_set behaviour
In-Reply-To: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1374748876-23461-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdb7bv82O22OhCVn0ZPWD-W-gWwJP1QJfKimgnvHfHba7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 12:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current gpio_set function is ignoring the previous value set in the
> GPIO value register, which leads in erasing the values already set for
> the other GPIOs in the same bank when setting the value of a given GPIO.
>
> Add the usual read/mask/write pattern to fix this brown paper bag bug.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied for fixes.

Yours,
Linus Walleij

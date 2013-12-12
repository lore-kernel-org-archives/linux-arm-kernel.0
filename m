From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 22:16:12 +0100
Subject: [PATCH v2 2/3] pinctrl: Add msm8x74 configuration
In-Reply-To: <CACRpkdY9Z71VcS6ERiaDbg9P7qPEK_jCVXLvoCDx6YztYCnR2Q@mail.gmail.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
 <52A24E08.706@codeaurora.org>
 <20131210084140.GF11990@sonymobile.com>
 <52A7C4BB.6000701@codeaurora.org>
 <CACRpkdY9Z71VcS6ERiaDbg9P7qPEK_jCVXLvoCDx6YztYCnR2Q@mail.gmail.com>
Message-ID: <CACRpkdZedEataWivqxL4vN4Xy+KtZDuZyH7AoqXUhNxHKBKdrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 8:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> On a related key I guess drivers/gpio/gpio-msm-v2.c needs
> to be patched to call pinctrl_request_gpio()/
> pinctrl_free_gpio()/pinctrl_gpio_direction_input()/
> pinctrl_gpio_direction_output() before the GPIO back-end
> works at all so there is still time to change this (plus it is
> not part of the DT binding or anything so it can be changed
> at any time).

I think Bj?rn answered this in his other mail - so the new
pin control driver replaces the GPIO drivers' functionality
and that's just fine.

Yours,
Linus Walleij

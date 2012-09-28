From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 10:40:50 +0200
Subject: [PATCH 1/2] pinctrl: add bcm2835 driver
In-Reply-To: <1348805412-7804-1-git-send-email-swarren@wwwdotorg.org>
References: <1348805412-7804-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdbpGUfcE8mG7iPA_kocj3XGw8QSL37NMS+-KXgNGoqK9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 6:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Simon Arlott <simon@fire.lp0.eu>
>
> The BCM2835 GPIO module is a combined GPIO controller, (GPIO) interrupt
> controller, and pinmux/control device.
>
> Original driver by Simon Arlott.
> Rewrite including GPIO chip device by Chris Boot.

It's such a sweet thing that I can't resist it, and since it's
a new driver it's OK this late in the cycle, so:
patch applied.

Yours,
Linus Walleij

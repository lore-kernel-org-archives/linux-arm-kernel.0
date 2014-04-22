From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 23:47:52 +0200
Subject: [PATCH 0/4] pinctrl: sirf: switch to one gpiolib and
 gpiolib_irqchip helpers
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdY6N3vh2-a5NwU0ZkXKsf8ArmxLBCL3dMrPTFwvN+x5JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> This patchset depends on Linus Walleij's "pinctrl: sirf: rename inlined accessor".
> and "pinctrl: sirf: switch driver to use gpiolib irqchip helpers" is rebased
> from Linus Walleij's patch too.
>
> Barry Song (3):
>   pinctrl: sirf: wrap all gpio banks into one gpio_chip
>   gpio: make handler_data configurable while using gpiolib_irqchip
>   pinctrl: sirf: move to use irq_get_handler_data
> Linus Walleij (1):
>   pinctrl: sirf: switch driver to use gpiolib irqchip helpers

As mentioned I can't get this series to apply so please rebase,
resend and take this opportunity to also add relevant ACKs.

Yours,
Linus Walleij

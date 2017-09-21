From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 14:12:00 +0200
Subject: [PATCH] pinctrl: bcm2835: fix build warning in
 bcm2835_gpio_irq_handle_bank
In-Reply-To: <20170919190456.26522-1-clabbe.montjoie@gmail.com>
References: <20170919190456.26522-1-clabbe.montjoie@gmail.com>
Message-ID: <CACRpkdYFL-NwxPSsyTxJqq=Yqi4S=JjjZWc1W80EuqmUcZ0tcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 9:04 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:

> This patch fix the following build warning:
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:376:15: warning: variable 'type' set but not used [-Wunused-but-set-variable]
>
> Furthermore, it is unused for a long time, at least since commit 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
> where a "FIXME no clue why the code looks up the type here" was added.
> A year after, nobody answeered this question, so its time to remove it.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Patch applied with Stefan's ACK.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Sep 2018 11:28:38 +0200
Subject: unexpected side effect of "gpiolib: override irq_enable/disable"
In-Reply-To: <CACRpkdaDgWckvtwik4S8WRBOA-DvOobjAPBM2_6SN4U5gw+Omg@mail.gmail.com>
References: <20180912145829.hzklqndjasac2ap4@M43218.corp.atmel.com>
 <f64fcb6a-172f-45e8-af8f-f1e7bae3b4d8@xs4all.nl>
 <20180913074742.7cdvfiosb3nyc4ui@M43218.corp.atmel.com>
 <a6ab8cfd-f245-5607-f720-8e5b607e7136@xs4all.nl>
 <CACRpkdaDgWckvtwik4S8WRBOA-DvOobjAPBM2_6SN4U5gw+Omg@mail.gmail.com>
Message-ID: <CACRpkdY7b42uzsk7v07=NVvmYTM_Y5U9dNwC-t5rni1EL2=C0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 11:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> I think what we should do is apply this fix, then annotate the
> drivers that use the same irqchip with multiple gpiochips with
> some
> FIXME: this is bad practice
> comments.

Bonus: if you can get the core to also print a little naggy
pr_info-level note to fix up the gpio driver, that would be great.

Yours,
Linus Walleij

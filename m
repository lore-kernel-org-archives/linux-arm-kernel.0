From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Sep 2014 11:19:20 +0200
Subject: [PATCH 5/9] gpio: vf610: Extend with wakeup support
In-Reply-To: <704b6bb97147b3d0ee1557b43d85ab9376c28666.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
 <704b6bb97147b3d0ee1557b43d85ab9376c28666.1411404079.git.stefan@agner.ch>
Message-ID: <CACRpkdYCiKzyVpg9u-YXn-QMd7PSKR72siXQQWALe0OqTNr-rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 7:09 PM, Stefan Agner <stefan@agner.ch> wrote:

> Support Vybrid GPIO's as wakeup source by requesting the parent
> IRQ as wakeup IRQ.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpio/gpio-vf610.c | 16 ++++++++++++++++

This driver is not yet upstream. Make wakeup support part
of the initial driver submission instead, it doesn't hurt.

Yours,
Linus Walleij

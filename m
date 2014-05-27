From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 15:25:43 +0200
Subject: [PATCH] pinctrl: sirf: fix typo for GPIO bank number
In-Reply-To: <1401008064-31819-1-git-send-email-21cnbao@gmail.com>
References: <1401008064-31819-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdZhuVMichd4ZEDd0Q2ZczF6Hy692rohi6Z2gY8NBnwtLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 10:54 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> The patch 7420d2d09b12: "pinctrl: sirf: switch driver to use gpiolib
> irqchip helpers" from Apr 15, 2014, leads to the following static
> checker warning:
>
>       drivers/pinctrl/sirf/pinctrl-sirf.c:578 sirfsoc_gpio_handle_irq()
>       warn: buffer overflow 'sgpio_chip.sgpio_bank' 5 <= 31
>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied!

Yours,
Linus Walleij

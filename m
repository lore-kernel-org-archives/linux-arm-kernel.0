From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 08:55:26 +0100
Subject: [PATCH v2 1/2] at91: gpio: use gpiolib API to mark a GPIO used as
 an IRQ
In-Reply-To: <1390473478-5591-2-git-send-email-jjhiblot@traphandler.com>
References: <1390473478-5591-1-git-send-email-jjhiblot@traphandler.com>
 <1390473478-5591-2-git-send-email-jjhiblot@traphandler.com>
Message-ID: <CACRpkdZ4LxkRERfD-prZvJSOZyomgf8v8P+vLhb_+hrSkL8rzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 11:37 AM, Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:

> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Nicolas, are you queueing this patch?

I guess this custom GPIO implementation is going away with
the transition to pinctrl else I'd requested that it be moved to
drivers/gpio...

Yours,
Linus Walleij

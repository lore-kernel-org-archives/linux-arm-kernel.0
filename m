From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 11:20:57 +0200
Subject: [PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ
 flags
In-Reply-To: <1371228049-27080-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371228049-27080-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CACRpkdafxpwuaUHLb3uHiPNrKLsmcekqG1ATQKj8fgz+ekXmDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 6:40 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_get_irq_data(irq))
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If you get the other patches ACKed.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:43:39 +0200
Subject: [PATCH v2 02/11] irqchip: versatile-fpga: Add IRQCHIP_DECLARE
 support
In-Reply-To: <1401403221-27523-3-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-3-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbYRmckfvJcAgVzkp8oVZ-TiVpmBgREK+RS7SMuOkb5-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Add support for initialization using IRQCHIP_DECLARE. This also requires
> that the controller initialization set the handle_irq function pointer
> itself when it is a primary controller.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
> v2:
> - New patch

I just assume you know what you're doing ;-)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

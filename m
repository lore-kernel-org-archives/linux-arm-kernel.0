From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Sep 2011 13:47:31 +0200
Subject: [PATCH v2 10/16] ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-11-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdY_24LptsjW5WMd6PCw6GsCYDO4LM1v8LDMRL8b7yj5Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 1:02 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Convert the ux500 platforms to be using the gic_handle_irq
> function as their primary interrupt handler.
>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Seems straight-forward provided the first patch is working
good so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij

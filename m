From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jan 2012 00:53:11 +0100
Subject: [PATCH 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdaePjAAkbE7QW-SP4FMa8Wx8LonqBpN+CdzwjOuYE8WVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 2:08 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Add support for the new smp_twd runtime registration interface
> to the ux500 platforms, and remove the old compile-time support.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Looks good! There will be collisions with the plat-nomadik
timers I sent out yesterday, so I don't know if it makes sense
to bring all timer stuff on a single ARM-SoC branch?
(Or the SoC maintainers rely on git rerere...)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 15:54:20 +0200
Subject: [PATCH 2/4] pinctrl: sunxi: Add external interrupts support
In-Reply-To: <1370685946-3718-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370685946-3718-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbDNSGSH-Y9_P4Bfpt3HhW0JBE7OWZt7of83=oLv_op7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 8, 2013 at 12:05 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The port controller IP found in the Allwinner A10 and A13 can use few of
> the pins it manage as an interrupt source, called external interrupts in
> the datasheet.
>
> The number of these external interrupts are SoCs specific, but the
> current upper limit is 32. In order to work, the external interrupts'
> pins have to be muxed to a specific function to generate an interrupt.
>
> This patch adds the irqchip and the needed logic to use the PIO
> controller as an interrupt controller.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Pretty complicated but I think I understand it at last...

Patch applied.

Yours,
Linus Walleij

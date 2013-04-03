From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 14:35:27 +0200
Subject: [PATCH 2/2] ARM: remove mach .init_irq for irqchip_init users
In-Reply-To: <1364503606-10597-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364503606-10597-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdapQB7=fem1x8v5nAzitAVMZAe=P4Eroz-wmmK1CQSMgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 9:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Now that the arm core code calls irqchip_init, we can remove it from all
> the machines that were using it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For Nomadik.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 11:04:13 +0200
Subject: [PATCH v4 1/4] dt-bindings: brcmstb-gpio: document properties for
 wakeup
In-Reply-To: <1438391865-7862-2-git-send-email-gregory.0xf0@gmail.com>
References: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
 <1438391865-7862-2-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdaZj=vt_nPOxh+PCH6n1i8MkzcoicYwUGAMFyP_MPg_yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 1, 2015 at 3:17 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> Some brcmstb GPIO controllers can be used to wake from suspend, so use
> the de facto standard property 'wakeup-source' to mark the nodes of
> controllers with that capability.
>
> Also document interrupts-extended, which will be used for wakeup
> handling because the interrupt parent for the wake IRQ is different
> from the regular IRQ.
>
> While we're at it, a few more fixes: We don't actually use the
> "interrupt-names" property, so remove it from the listed optional
> properties and from the examples.  And since we're modifying the
> examples, also follow Brian's suggestions to:
> - change #gpio-cells, #interrupt-cells, and brcm,gpio-bank-widths from
>   hex to dec
> - use phandles
>
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v4: no changes from v3

I've already applied this, no action.

Yours,
Linus Walleij

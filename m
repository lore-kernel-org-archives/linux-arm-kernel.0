From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:12:20 +0200
Subject: [PATCH v4 0/9] Initial Allwinner H6 support
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Message-ID: <CACRpkdYW4N-zuPGGz+=GHUX69xBTS3w=EYhiP7dDvr+DZNUJUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> This patchset adds initial support for the Allwinner H6 SoC.
>
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface (although the implementation
> of the PCI Express controller is broken), and the second one with USB
> 3.0 (the first one is A80).
>
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.
>
> Icenowy Zheng (9):
>   pinctrl: sunxi: refactor irq related register function to have desc
>   pinctrl: sunxi: introduce IRQ bank conversion function
>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
>   pinctrl: sunxi: add support for the Allwinner H6 main pin controller

I applied these pinctrl patches for v4.17 so anything dependent on that
can now be merged.

Yours,
Linus Walleij

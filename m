From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Mar 2018 09:51:56 +0100
Subject: [PATCH v3 0/7] Initial Allwinner H6 support
In-Reply-To: <20180223122552.58049-1-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
Message-ID: <CACRpkdYtTLV1R+LpPp8J8uGX9f7sFXOkPuH8du0zz_v=FZHMBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 1:25 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> This patchset adds initial support for the Allwinner H6 SoC.
>
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface, and the second one with USB
> 3.0 (the first one is A80).
>
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.

It seems the pin control part is more or less finished, I will
apply it after v4 if Maxime provides ACKs for it.

Is it fine to merge the pinctrl drivers/* portions in isolation from the
rest?

Yours,
Linus Walleij

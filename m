From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:08:39 +0200
Subject: [PATCH v4 3/9] pinctrl: sunxi: change irq_bank_base to
 irq_bank_map
In-Reply-To: <20180316140215.28663-4-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-4-icenowy@aosc.io>
Message-ID: <CACRpkdaq6RYNdk5H4bFEJxfCErg0veqxY563uPr3W8d3cA9vZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5.
>
> Change the current code that uses IRQ bank base to a IRQ bank map, in
> order to support the case that holes exist among IRQ banks.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij

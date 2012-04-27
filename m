From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 20:57:54 +0200
Subject: [PATCH 02/12] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
In-Reply-To: <E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbC9GhwEs+qEt8-vurpbXJFtRcsgkg+S4Au16WG3RsKLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 6:04 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Split the virtual slave channel DMA support from the sa11x0 driver so
> this code can be shared with other slave DMA engine drivers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I really like the direction of this thing.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

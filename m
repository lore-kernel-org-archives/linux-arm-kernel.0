From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 23:31:58 +0200
Subject: [RFC PATCH 00/33] SA11x0/PXA GPIO rework (Core + PCMCIA only)
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <CACRpkdYuAh1r+N_yJkb9G24Y4zVvEdR8=U-K7etCQvuSZtr+6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:23 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Following on from the PCMCIA fixes, this series reworks GPIO on SA11x0
> and PXA platforms.  This is a subset of a larger series, which I'm
> splitting up due to its size.  This part contains the base and PCMCIA
> updates.  Further updates for IrDA drivers, DMA engine, serial, and
> ethernet will follow in time.

For all the GPIO patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

With the smallish changes needed to patch 5/33 that one is acked too.

In fact I would ACK it anyway, because the net total cleanup is so
nice on the kernel at large... SA11x0 has never been prettier than
after this series.

I suspect you want to keep the series together and queue it in the ARM
tree? Else tell me what to apply in the GPIO tree.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:47:30 +0800
Subject: [RFC 05/34] dmaengine: PL08x: fix missed dma_transfer_direction
 fixup
In-Reply-To: <E1SZIrK-0006z2-CV@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIrK-0006z2-CV@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbzsBW6oJ+NpgGttuPe9FVBqyW=dXnH+Ebx=bw1xigJhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:36 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> db8196df4 (dmaengine: move drivers to dma_transfer_direction) missed
> fixing up the "DMA_NONE" case.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks like it should go into the -rc:s really?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

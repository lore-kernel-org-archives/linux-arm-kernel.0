From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Jun 2017 14:20:42 +0200
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported
 implementation
In-Reply-To: <20170608132609.32662-34-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-34-hch@lst.de>
Message-ID: <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Thu, Jun 8, 2017 at 3:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> This implementation is simply bogus - hexagon only has a simple

openrisc?

> direct mapped DMA implementation and thus doesn't care about the
> address.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/include/asm/dma-mapping.h | 7 -------

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

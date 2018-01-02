From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 Jan 2018 11:38:07 +0100
Subject: [PATCH 22/67] dma-mapping: clear harmful GFP_* flags in common
 code
In-Reply-To: <20171229081911.2802-23-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-23-hch@lst.de>
Message-ID: <CAMuHMdX6+E0tN-qxybQ27DoygpUsWngi8J+Fz6K2WZ=FCCuO_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Life the code from x86 so that we behave consistently.  In the future we
> should probably warn if any of these is set.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

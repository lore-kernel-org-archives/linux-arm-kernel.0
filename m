From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Jun 2018 15:02:00 +0200
Subject: [PATCH/RFT v2 1/2] arm64: dts: r8a77995: Add SCIF-{0, 1, 3, 4, 5}
 device nodes
In-Reply-To: <20180613151348.28697-1-horms+renesas@verge.net.au>
References: <20180613151348.28697-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWJ24iCA=YQdoE99+1aVw8LNw3hRAGGbET6qAJNt4=QoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jun 13, 2018 at 5:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds the device nodes for SCIF-{0,1,3,4,5} serial ports,
> incl. clocks and power domain.

While at it, perhaps you want to add DMA properties, too?
The existing SCIF2 device node already has them.

> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> [simon: updated internal clock from S3D1 to S3D1C to match documentation]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

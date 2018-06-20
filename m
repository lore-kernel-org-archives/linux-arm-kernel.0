From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Jun 2018 15:04:20 +0200
Subject: [PATCH/RFT v2 2/2] arm64: dts: r8a77995: Add all HSCIF nodes
In-Reply-To: <20180613150951.32322-1-horms+renesas@verge.net.au>
References: <20180613150951.32322-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVZKqCriwJcXNL0koq1iZJOUrD_623yXLz1LEwCwbQZPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 5:10 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds the device nodes all HSCIF serial ports
> incl. clocks and power domain to the R8A77995 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> [simon: updated internal clock from S3D1 to S3D1C to match documentation]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

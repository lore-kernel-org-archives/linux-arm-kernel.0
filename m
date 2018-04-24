From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 24 Apr 2018 16:51:50 +0200
Subject: [PATCH] arm64: renesas_defconfig: enable R8A77980 SoC
In-Reply-To: <20180423104635.18129-1-horms+renesas@verge.net.au>
References: <20180423104635.18129-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXMZ3bb6qFSeQhb5tmqHXwJQt8Pni4=aHYtYTRDXGZgHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 12:46 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable the Renesas R-Car V3H (R8A77980) SoC in the ARM64 renesas_defconfig.

"E3 (R8A77990)", also in the one-line summary.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

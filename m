From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 3 Jan 2018 15:07:04 +0100
Subject: [PATCH v3 3/3] arm64: dts: renesas: r8a7796: Add OPPs table for
 cpu devices
In-Reply-To: <20180103124105.1999-4-horms+renesas@verge.net.au>
References: <20180103124105.1999-1-horms+renesas@verge.net.au>
 <20180103124105.1999-4-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWciOeHb22xaZcuCA_W-Bu1+s+51zDPRGhiyWzGZFTsMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 1:41 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>
> Define OOP tables for all CPUs.
> This allows CPUFreq to function.
>
> Based in part on work by Hien Dang.
>
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looks good and matches the bindings.
I cannot verify the operating point tuples, though.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

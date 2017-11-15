From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Nov 2017 17:15:58 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
In-Reply-To: <20171113213152.819421744@cogentembedded.com>
References: <20171113213152.819421744@cogentembedded.com>
Message-ID: <CAMuHMdUqX6OhsKBET5RkL0zcZO-aiTT4wHHuwuRTeVHAYkSnZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 10:23 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
> have the GPIO support (previously phylib had to resort to polling).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

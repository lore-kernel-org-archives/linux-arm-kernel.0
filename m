From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Sep 2016 11:10:35 +0200
Subject: [PATCH 3/3] ARM: dts: wheat: add QSPI support
In-Reply-To: <3191777.fJ30rYXr4J@wasted.cogentembedded.com>
References: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
 <3191777.fJ30rYXr4J@wasted.cogentembedded.com>
Message-ID: <CAMuHMdW+82ePveuVbOrPU0uRj4Uu5f8+NvzHpjWQr8Wa_BoU+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 3, 2016 at 12:09 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the Wheat board dependent part of the QSPI device node.
> Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.
>
> Based  on the original (and large) patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Disclaimer: I have no board schematics nor manuals describing FLASH layout.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Aug 2015 08:59:08 +0200
Subject: [PATCH v2 2/2] ARM: shmobile: silk: add QSPI DT support
In-Reply-To: <7036752.0LCvRcbC9K@wasted.cogentembedded.com>
References: <4187771.Fb49GBKgyg@wasted.cogentembedded.com>
 <7036752.0LCvRcbC9K@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVVGCFheo+Eng2ET8_CJcaUrkXmubrZTDw0CyZ8_s7OHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 12:00 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the SILK board dependent part of the QSPI device node.
> Add device nodes  for Spansion  S25FL512S SPI flash and MTD partitions on it.
>
> Based on the original patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

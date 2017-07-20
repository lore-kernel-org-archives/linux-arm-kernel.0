From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Jul 2017 15:00:49 +0200
Subject: [PATCH 0/4] arm64: dts: renesas: Add Support for R-Car D3 and
 Draak
In-Reply-To: <1500555277-22921-1-git-send-email-geert+renesas@glider.be>
References: <1500555277-22921-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdXhTVLfp_j0SA4u8A0q0GhBrX7sGKNDEQu9=2jfaKMkUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 2:54 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series adds minimal support for the R-Car D3 SoC and the
> Draak development board, allowing to boot from a ramdisk using a serial
> console.

>   arm64: dts: renesas: r8a77995: Use r8a7795-sysc binding definitions
>   arm64: dts: renesas: r8a77995: Use r8a7795-cpg-mssr binding
                                       ^^^^^^^
                                       r8a77995

Bummer, these were the first (and definitely not the last :-( typos for R-Car
D3 part numbers...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

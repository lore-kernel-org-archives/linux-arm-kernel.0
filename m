From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 9 May 2018 16:39:19 +0200
Subject: [PATCH 0/8] ARM: dts: renesas: Add PMU device nodes
In-Reply-To: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
References: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdWLoQ+SnD29NLbmVWt3z3YJf-4BGsUx9Yog8VQg3r4J=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2018 at 3:56 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series enables support for the ARM Performance Monitor Units
> in Cortex-A7, Cortex-A9, and Cortex-A15 CPU cores on Renesas RZ/A1,
> R-Car Gen2, and RZ/G1 SoCs.  This allows for better performance analysis
> using the "perf" tool.

[...]

> This has been tested on r8a7791/koelsch, and boot-tested on
> r7s72100/genmai, r8a7790/lager, r8a7792/blanche, and r8a7794/silk.

... and r8a7793/gose and r8a7794/alt.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Oct 2016 14:08:44 +0200
Subject: [PATCH v4 0/7] Add R8A7743/SK-RZG1M board support
In-Reply-To: <2719479.geOc9vqcRS@wasted.cogentembedded.com>
References: <2719479.geOc9vqcRS@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUNgnYc1O7DATNH1r9SQ72eqtxwFvqcen08Tq+Er3LuvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Oct 21, 2016 at 10:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>    Here's the set of 8 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-20161021-v4.9-rc1' tag. I'm adding the device tree support for
> the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
> seems identical to the R8A7791/Porter board. The device tree patches depend on
> the R8A7743 CPG/MSSR driver series just posted in order to compile and work.

They depend only on "[PATCH v3 1/2] ARM: shmobile: r8a7743: add CPG clock
index macros" of that series, right?

"[PATCH v3 2/2] clk: renesas: cpg-mssr: add R8A7743 support" is not needed,
and introduces an additional dependency on "[PATCH 1/3] clk: renesas:
cpg-mssr: add common R-Car Gen2 support".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

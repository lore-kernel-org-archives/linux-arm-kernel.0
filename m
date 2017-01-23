From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Jan 2017 11:14:11 +0100
Subject: [PATCH 4/8] clk: renesas: cpg-mssr: Add support for reset control
In-Reply-To: <20170120220302.GA20610@bigcity.dyn.berto.se>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
 <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
 <20170120220302.GA20610@bigcity.dyn.berto.se>
Message-ID: <CAMuHMdUu=FwygW168GLVp2JtKbbB_R2wQLzq_3_TxLiu5ww6kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Fri, Jan 20, 2017 at 11:03 PM, Niklas S?derlund
<niklas.soderlund@ragnatech.se> wrote:
> Nice patch! It took me a while to understand why you didn't need to read
> the register before writing to it in cpg_mssr_deassert() :-)

Yeah, deassertion and assertion are asymmetrical.

Note that on older (not yet supported) SH/R-Mobile parts, there are no
reset clear registers, and deassertion is symmetrical.

> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

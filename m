From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Aug 2016 19:55:04 +0200
Subject: Build regressions/improvements in v4.8-rc2
In-Reply-To: <1471283586-26886-1-git-send-email-geert@linux-m68k.org>
References: <1471283586-26886-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdU+CPs6nurGrw2Ogz74tQeRhuwq_0eEFByyCUeP18=ywg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 7:53 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.8-rc2[1] to v4.8-rc1[3], the summaries are:
>   - build errors: +6/-3

  + error: zynq-fpga.c: undefined reference to `clk_round_rate':  =>
.text+0x3234c0), .text+0x350bd4), .text+0x17f780), .text+0x350d44),
.text+0x34ad7c), .text+0x2b2588), .text+0x34ad64), .text+0x34ae3c)
  + error: zynq-fpga.c: undefined reference to `clk_set_parent':  =>
.text+0x143838)
  + error: zynq-fpga.c: undefined reference to `clk_set_rate':  =>
.text+0x350014), .text+0x34ffc4), .text+0x2b2598), .text+0x35430c),
.text+0x13ed64), .text+0x352fb8), .text+0x34ada8), .text+0x3942ec),
.text+0x350db4), .text+0x17f794), .text+0x149e4c), .text+0x34eeb0),
.text+0x34f8d0), .text+0x323510), .text+0x76124), .text+0x148cf0),
.text+0x354258)

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10769/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10730/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

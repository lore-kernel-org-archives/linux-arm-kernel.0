From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 3 Apr 2016 22:42:13 +0200
Subject: Build regressions/improvements in v4.6-rc2
In-Reply-To: <1459716033-31934-1-git-send-email-geert@linux-m68k.org>
References: <1459716033-31934-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdUmcF4h=FNs_PCKLMjKZBr2Nc_VbShy-wN1_9g=9uok8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 3, 2016 at 10:40 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.6-rc2[1] to v4.6-rc1[3], the summaries are:
>   - build errors: +5/-4

  + error: qfprom.c: undefined reference to `clk_round_rate':  =>
.text+0x310254), .text+0x3103a8), .text+0x1f7550)
  + error: qfprom.c: undefined reference to `clk_set_parent':  =>
.text+0x246ca0)
  + error: qfprom.c: undefined reference to `clk_set_rate':  =>
.text+0x3103e8), .text+0x24be0c), .text+0x1f771c), .text+0x1dff48),
.text+0x1f76d8)

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10139/ (261 out of 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10114/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

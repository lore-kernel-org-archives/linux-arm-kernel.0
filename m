From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Dec 2016 09:12:43 +0100
Subject: Build regressions/improvements in v4.9
In-Reply-To: <1481616682-3605-1-git-send-email-geert@linux-m68k.org>
References: <1481616682-3605-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdWPCRzeAEiJ6hTDr7_E3EZRRGC3oLMRsxd8RUtjNo8wEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 9:11 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.9[1] to v4.9-rc8[3], the summaries are:
>   - build errors: +3/-4

  + error: page_ext.c: undefined reference to
`__end_data_ro_after_init':  => .text+0x19860)
  + error: page_ext.c: undefined reference to
`__start_data_ro_after_init':  => .text+0x1985c)

arm-randconfig (CONFIG_XIP_KERNEL=y, patch available since 3 weeks)

> [1] http://kisskb.ellerman.id.au/kisskb/head/69973b830859bc6529a7a0468ba0d80ee5117826/ (all 267 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/3e5de27e940d00d8d504dfb96625fb654f641509/ (all 267 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

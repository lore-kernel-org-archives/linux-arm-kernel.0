From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jul 2015 11:53:59 +0200
Subject: Build regressions/improvements in v4.2-rc2
In-Reply-To: <1436779733-13678-1-git-send-email-geert@linux-m68k.org>
References: <1436779733-13678-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdX9pW3n+sD6zGFezZvDEcGvMmZobUDik4GYESh6iCgY5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 11:28 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.2-rc2[1] to v4.2-rc1[3], the summaries are:
>   - build errors: +7/-5

  + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of
function 'copy_user_page' [-Werror=implicit-function-declaration]:  =>
267:2

sh-randconfig (patch from Arnd updated and forwarder)

  + error: coresight-etm-cp14.c: undefined reference to
`clk_add_alias':  => .init.text+0x12b0c)

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9134/ (all 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9102/ (all 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

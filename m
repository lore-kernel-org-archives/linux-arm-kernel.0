From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Sep 2015 08:57:44 +0200
Subject: Build regressions/improvements in v4.3-rc3
In-Reply-To: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
References: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 9:34 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.3-rc3[1] to v4.3-rc2[3], the summaries are:
>   - build errors: +8/-12

  + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9404/ (255 out of 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9376/ (all 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

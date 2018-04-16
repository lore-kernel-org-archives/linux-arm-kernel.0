From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Apr 2018 18:27:33 +0200
Subject: [PATCH] ARM: dts: renesas: replace toshiba, mmc-wrprotect-disable
 with disable-wp
In-Reply-To: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAMuHMdWYOPPzo6HJF5H+L8x6vWwcQMCYS-eV-Xz0AS2FtQ8c1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

On Mon, Apr 16, 2018 at 5:02 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Follow up commit 788778b0d21a ("mmc: tmio: deprecate "toshiba,
> mmc-wrprotect-disable" DT property").

Thanks for following up this work.

(I had the exact same changes queued up in my local branch, to be sent out
 after v4.17-rc1, but you beat me to it ;-)

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

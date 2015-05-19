From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 May 2015 21:37:32 +0200
Subject: [PATCH] ARM: lpc18xx: define low-level debug symbol for
 LPC18xx/43xx
In-Reply-To: <1432061703-29104-1-git-send-email-manabian@gmail.com>
References: <1432061703-29104-1-git-send-email-manabian@gmail.com>
Message-ID: <CAMuHMdU=MAr3nGE0cXH0X3a5eEqsw13b_WESYayoCABz4Z_YcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Tue, May 19, 2015 at 8:55 PM, Joachim Eastwood <manabian@gmail.com> wrote:
> Using a dedicated symbol for low-level debugging instead of the
> arch symbol will make this platform play nice when enabled on a
> kernel that supports multiple platforms.

Thanks a lot!

> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

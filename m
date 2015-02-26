From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 26 Feb 2015 14:32:31 +0100
Subject: [PATCH] regulator: wm8350: remove unused variable
In-Reply-To: <2131808.TgSGZRWdu2@wuerfel>
References: <2131808.TgSGZRWdu2@wuerfel>
Message-ID: <CAMuHMdWAu_rkzOOqhKdQ+4u1MDv-yN4kdPy5xnvdHe_3Gn=PgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 11:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> After the only user of the variable has been removed, we get a valid gcc
> warning about it:
>
> regulator/wm8350-regulator.c:1154:17: warning: unused variable 'wm8350' [-Wunused-variable]
>
> The obvious fix is to remove the variable as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 8f45acb5f9f34 ("regulator: wm8350: Pass NULL data with REGULATION_OUT and UNDER_VOLTAGE events")

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Mea culpa. Second ack on the same patch today...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

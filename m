From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Mar 2016 11:25:10 +0100
Subject: [PATCH 2/2] char: genrtc: replace blacklist with whitelist
In-Reply-To: <1456912137-1578635-2-git-send-email-arnd@arndb.de>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <1456912137-1578635-2-git-send-email-arnd@arndb.de>
Message-ID: <CAMuHMdVRBLd0hhBLC_pxbzCv3qwjPWhHyvVV3+ikgqytiaLqfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Every new architecture has to add itself to the growing list of those
> that do not support the old "generic" RTC driver.
>
> This replaces the long list of architectures that don't support it
> with a shorter list of those that do.
>
> The list is taken from those architectures that have a non-empty
> asm/rtc.h header file and were not explicitly blacklisted.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

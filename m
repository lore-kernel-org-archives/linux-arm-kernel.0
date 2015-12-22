From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Dec 2015 16:06:06 +0100
Subject: [PATCH 00/10] ARM: debug-ll fixes
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <CAMuHMdW=U2x2sabVcsge-VKj7FwuPLZniKdoiKOkGZSJmqamDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Dec 4, 2015 at 11:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I've carried most of these patches for a very long time in
> my randconfig tree, and they follow up on work that Daniel
> Thompson did last year. Most of the changes are really trivial,
> and I'd like to put them into my next/randconfig branch in
> arm-soc for merging in 4.5.
>
> The last patch for orion/mvebu is the only one that is slightly
> tricky, but it would be good to have that as part of the
> multiplatform conversion for orion5x/mv78xx0.
>
> The patches are currently based on top of my randconfig branch,
> and there will be conflicts trying to apply them on mainline,
> but I can handle that inside of arm-soc.

Now this is in arm-soc/for-next, I've dropped my local commit "[DEBUG] Remove
all non-shmobile DEBUG_UART_PHYS defaults", and the value of
CONFIG_DEBUG_UART_PHYS stays sane when enabling DEBUG_LL in
multi_v7_defconfig.

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

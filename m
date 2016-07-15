From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Jul 2016 05:10:39 +0200
Subject: [GIT PULL v2] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.8
In-Reply-To: <8207439.0JmbbpvM5T@wuerfel>
References: <cover.1467900241.git.horms+renesas@verge.net.au>
 <8207439.0JmbbpvM5T@wuerfel>
Message-ID: <CAMuHMdXVEdqMi_J-7ECF58i1n4xF8zQiO99fiOt4OeFGoi_C-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Jul 14, 2016 at 5:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, July 7, 2016 4:39:45 PM CEST Simon Horman wrote:
>>       arm64: dts: r8a7796: Add SYSC PM Domains
>
> While doing some sanity checks on our branch contents, I noticed
> that this commit breaks running "make dtbs" on top of our next/dt64
> branch, and I'd like to avoid that.
>
> I found a couple more problems (tegra and meson), and I ended up
> fixing them all up (by merging the dependencies into next/dt64),
> so everything is sorted for 4.8, but it would be good to do a
> 'make dtbs' run on a branch that has dt changes before you send it,
> and I'll try to do the same when pulling it to avoid the problem in
> the future.

Oh right, it can't find <dt-bindings/power/r8a7796-sysc.h>.
I guess this didn't  show up for us, as arm64 defconfig in
renesas-arm64-dt2-for-v4.8 doesn't enable CONFIG_ARCH_R8A7796 yet.

Sorry for that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

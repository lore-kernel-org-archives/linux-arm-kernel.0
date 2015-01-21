From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Jan 2015 11:46:34 +0100
Subject: [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
In-Reply-To: <20150121045357.7648.6160.sendpatchset@little-apple>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045357.7648.6160.sendpatchset@little-apple>
Message-ID: <CAMuHMdW7WF00LHheNAkQZQizrO0MH91EScuuR1_hwebRqznXrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wed, Jan 21, 2015 at 5:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Remove the defconfig for the no longer supported mackerel board.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/configs/mackerel_defconfig |  157 -----------------------------------
>  1 file changed, 157 deletions(-)

You forgot the reference to mackerel_defconfig in MAINTAINERS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

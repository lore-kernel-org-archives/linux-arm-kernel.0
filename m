From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 May 2014 09:42:15 +0200
Subject: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
In-Reply-To: <20140511231050.19908.86623.sendpatchset@w520>
References: <20140511231050.19908.86623.sendpatchset@w520>
Message-ID: <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
> and CPUIdle in case of C-code less board support for r8a7740.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

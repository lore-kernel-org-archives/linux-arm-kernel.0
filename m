From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Jun 2017 19:07:08 +0200
Subject: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
In-Reply-To: <20170613130430.4272-1-robdclark@gmail.com>
References: <20170613130430.4272-1-robdclark@gmail.com>
Message-ID: <CAMuHMdWOkXXWteNrOTKyNcHzbrmTJBODLb=NMyUK5y_r4Tea8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jun 13, 2017 at 3:04 PM, Rob Clark <robdclark@gmail.com> wrote:
> In fact, it is needed for PCI to work on msm8996 (and probably other
> things).  No idea why it was depending on renesas but that doesn't make
> any sense.  So drop the dependency.

At that time, Renesas SoCs were the only users of it.

Actually at that time I wanted the functionality of simpe-pm-bus to be
included in simple-bus, but the DT maintainers didn't see the merits of that.

> Signed-off-by: Rob Clark <robdclark@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

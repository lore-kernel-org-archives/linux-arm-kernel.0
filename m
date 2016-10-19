From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Oct 2016 16:07:03 +0200
Subject: [PATCH v2 0/2] ARM: at91: properly handle LPDDR poweroff
In-Reply-To: <20161019114420.15213-1-alexandre.belloni@free-electrons.com>
References: <20161019114420.15213-1-alexandre.belloni@free-electrons.com>
Message-ID: <CAMuHMdUnoHPOQeO=oSRkNWbfLGDzZbBZvPFr3dS7TOKPQFcUxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 1:44 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> LPDDR memories can only handle up to 400 uncontrolled power offs in their
> life. The proper power off sequence has to be applied before shutting down the
> SoC.

Interesting. How many boards have been killed during kernelci.org
operation?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

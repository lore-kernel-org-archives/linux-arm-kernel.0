From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 May 2014 10:39:46 +0200
Subject: [PATCH/RFC] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <20140516080825.GA23295@verge.net.au>
References: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
 <20140516020549.GB18137@verge.net.au>
 <CAMuHMdVEowWbMY+L1TuC4xxYvtGZiH5qYOjmd7-rt1e_=xEz1A@mail.gmail.com>
 <20140516080825.GA23295@verge.net.au>
Message-ID: <CAMuHMdVG0=JG+d=_B9XM2OWn157UG4=2gsg2mfuRNwJ7N3qZFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, May 16, 2014 at 10:08 AM, Simon Horman <horms@verge.net.au> wrote:
> With that in mind I'll rephrase my question: are you are ware
> of any patches this one (the defconfig update) should depend on?

No, I don't think it will introduce any regressions.
We had CONFIG_PM_RUNTIME in most other defconfigs, and I've been
running quite some real multi-platform kernels on Koelsch before.

All known clock issues, for which patches have been send/accepted, happen
regardless of the value of CONFIG_PM_RUNTIME.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

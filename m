From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 5 Apr 2015 11:04:56 +0200
Subject: [PATCH 00/14] Fix fallout from per-user struct clk patches
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdWue2Pw15j_2ikhSQWxOMGLLO4ojmmyxSvZ=9YwD_+14w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Apr 3, 2015 at 7:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Sorry for posting this soo close to the 4.1 merge window, I had
> completely forgotten about this chunk of work I did earlier this
> month.
>
> The per-user struct clk patches rather badly broke clkdev and
> various other places.  This was reported, but was forgotten about.
> Really, the per-user clk stuff should've been reverted, but we've
> lived with it far too long for that.
>
> So, our only other option is to now rush these patches into 4.1
> and hope for the best.
>
> The series cleans up quite a number of places too...

Thanks for your patches!

Can you please tell which are critical fixes for regressions, and which are
cleanups? It's not so obvious to me from the patch descriptions.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Feb 2014 09:52:27 +0100
Subject: [PATCH] ARM: shmobile: Remove __init from
 rcar_gen2_read_mode_pins()
In-Reply-To: <20140217063510.21892.52120.sendpatchset@w520>
References: <20140217063510.21892.52120.sendpatchset@w520>
Message-ID: <CAMuHMdUqTQnngm9kY5oz-n2s8=qtS5XsTXF8rvNS1PFRJvK7Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 7:35 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Remove __init from rcar_gen2_read_mode_pins() to allow
> it to be used after boot. For instance the R-Car Gen2
> MD21 check is needed even in the case of CPU Hotplug.

This is a prerequisite for "[PATCH] ARM: shmobile: Check MD21 at SMP
boot in case of APMU"

> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

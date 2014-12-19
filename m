From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Dec 2014 09:13:29 +0100
Subject: [PATCH 4/4] PM: Eliminate CONFIG_PM_RUNTIME
In-Reply-To: <2635409.SWsBMlb9s4@vostro.rjw.lan>
References: <472992175.g1ArEYGFPo@vostro.rjw.lan>
 <2635409.SWsBMlb9s4@vostro.rjw.lan>
Message-ID: <CAMuHMdUn3KSTdh4nFL=G54SM7NWpQsmeg1GYYRz=+uXH9rbEGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 3:03 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> --- linux-pm.orig/arch/mips/configs/lemote2f_defconfig
> +++ linux-pm/arch/mips/configs/lemote2f_defconfig
> @@ -37,7 +37,7 @@ CONFIG_MIPS32_N32=y
>  CONFIG_PM=y
  ^^^^^^^^^^^
>  CONFIG_HIBERNATION=y
>  CONFIG_PM_STD_PARTITION="/dev/hda3"
> -CONFIG_PM_RUNTIME=y
> +CONFIG_PM=y
   ^^^^^^^^^^^
Now we have two of them

>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_DEBUG=y
>  CONFIG_CPU_FREQ_STAT=m

Other defconfig files may be affected, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

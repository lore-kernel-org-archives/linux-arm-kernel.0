From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Aug 2015 10:45:20 +0200
Subject: Build regressions/improvements in v4.2-rc7
In-Reply-To: <1439801034-23948-1-git-send-email-geert@linux-m68k.org>
References: <1439801034-23948-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdW=neYoFrTS5Nr8yvC0Zu1dJciZopWXS4=pcLyhWOctuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 10:43 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.2-rc7[1] to v4.2-rc6[3], the summaries are:
>   - build errors: +6/-14

  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'early_init_dt_scan_nodes'
[-Werror=implicit-function-declaration]:  => 244:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'early_init_dt_verify'
[-Werror=implicit-function-declaration]:  => 215:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_flat_dt_match_machine'
[-Werror=implicit-function-declaration]:  => 218:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_get_flat_dt_prop'
[-Werror=implicit-function-declaration]:  => 229:3
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_get_flat_dt_root'
[-Werror=implicit-function-declaration]:  => 228:3

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9260/ (all 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9234/ (253 out of 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

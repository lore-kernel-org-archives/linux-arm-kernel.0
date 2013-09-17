From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Sep 2013 16:23:51 +0200
Subject: [RFC PATCH 04/11] asm-generic: fncpy: Add function copying macros
In-Reply-To: <1379421817-15759-5-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
 <1379421817-15759-5-git-send-email-Russ.Dill@ti.com>
Message-ID: <CAMuHMdVT-hhJnww64mFa6nubHrHk-ZHuoe9GwGgBCEA2G0B2Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 2:43 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> +++ b/arch/alpha/include/asm/fncpy.h
> @@ -0,0 +1 @@
> +#include <asm-generic/fncpy.h>

Please add

    generic-y += fncpy.h

to arch/<arch>/include/asm/Kbuild instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

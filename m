From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 3 May 2017 17:05:29 +0200
Subject: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
In-Reply-To: <20170503145141.4966-2-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-2-ynorov@caviumnetworks.com>
Message-ID: <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -20,6 +20,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
>  #include <linux/hardirq.h>
> +#include <asm/spinlock.h>

linux/spinlock.h?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

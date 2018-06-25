From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 25 Jun 2018 11:24:48 +0200
Subject: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
 <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdVarwq26Jr=YN+zBDrHjQf-Q+u3L6oRNiSKh-hxuwOsrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Mon, Jun 25, 2018 at 10:31 AM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/smp-r9a06g032.c | 96 ++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

Given this doesn't depend on anything under arch/arm/mach-shmobile/,
perhaps this should be moved to drivers/soc/renesas/ (and renamed to
r9a06g032-smp.c for consistency) instead?

Simon: what do you think?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

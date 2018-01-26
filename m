From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 10:49:51 +0100
Subject: [RFC 01/37] ARM: shmobile: Add watchdog support
In-Reply-To: <CAMuHMdWVvMJR5NHMFn6zx39jw2XdP5nteU3actUcen0dmoT-LQ@mail.gmail.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWVvMJR5NHMFn6zx39jw2XdP5nteU3actUcen0dmoT-LQ@mail.gmail.com>
Message-ID: <CAMuHMdVkCscs1TN-se43TkZaCaKNdG2GLenApc7yRUkhD=pg2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 10:46 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
>> SMP bringup, CPU hot plug, and suspend to RAM work as normal.
>
> shmobile_boot_vector is not only used for R-Car Gen2 and RZ/G1 SoCs, but
> also for EMMA Mobile, SH/R-Mobile, and R-Car H1.  Hence this breaks SMP
> for the latter (and their build if ARCH_RENESAS=n, due to missing
> shmobile_wdt_clock_status).

Sorry, please ignore my comment about build failures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

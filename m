From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 May 2014 09:54:58 +0200
Subject: [PATCH 00/04] ARM: shmobile: Use shmobile_init_delay() on r8a7740
In-Reply-To: <20140507233219.29712.9253.sendpatchset@w520>
References: <20140507233219.29712.9253.sendpatchset@w520>
Message-ID: <CAMuHMdWkZ=pTCs_HgBnjPPExLj-fU4ywZq-aHUrpdLXLGT3WSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thu, May 8, 2014 at 1:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: Use shmobile_init_delay() on r8a7740
>
> [PATCH 01/04] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
> [PATCH 02/04] ARM: shmobile: Use r8a7740 DT CPU Frequency in common case
> [PATCH 03/04] ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
> [PATCH 04/04] ARM: shmobile: Remove unused r8a7740_init_delay()
>
> Convert r8a7740 to rely on shmobile_init_delay() instead of using a per-SoC
> delay setup function. This is a cleanup towards enabling Multiplatform support
> for the r8a7740 SoC.

Thanks!

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Tested-by: Geert Uytterhoeven <geert@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

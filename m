From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Jul 2017 15:45:43 +0200
Subject: [PATCH v 2/2] ARM: shmobile: defconfig: Enable Ethernet AVB
In-Reply-To: <1499259711-56175-3-git-send-email-biju.das@bp.renesas.com>
References: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
 <1499259711-56175-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdUAWXzdsp0NujnhKpajmv11aGZNeAA0PURUA1fP9NCrAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 5, 2017 at 3:01 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> The iWave RZ/G1M Q7 SOM supports Gigabit Ethernet Phy (Micrel KSZ9031MNX).
> Gigabit Ethernet support is available in Renesas AVB driver.
> To increase hardware support enable the driver in the shmobile_defconfig
> multiplatform configuration.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

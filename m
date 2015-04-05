From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 5 Apr 2015 10:46:33 +0200
Subject: [PATCH repost] ARM: shmobile: r8a7790: Remove MSIOF address from
 device tree
In-Reply-To: <1428166471-2897-1-git-send-email-ykaneko0929@gmail.com>
References: <1428166471-2897-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdW40S4rU-wkrJDHDw_ThFdChEa+HEyXYHJ3AAH1TwUiVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 4, 2015 at 6:54 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

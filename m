From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 10 Oct 2018 14:39:18 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add DMA properties to
 MSIOF nodes
In-Reply-To: <1539070730-20349-1-git-send-email-ykaneko0929@gmail.com>
References: <1539070730-20349-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdUhEt87dggNbZHjsDu0ZVjOSxbaZBDbA4nND+e_3o40tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2018 at 9:39 AM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> This patch adds DMA properties to the MSIOF device nodes of R8A77990 SoC.
>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
on Ebisu using a 25LC040 EEPROM
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm64/boot/dts/renesas/r8a77990-ebisu-cn41-msiof0-25lc040.dtso?h=topic/renesas-overlays

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

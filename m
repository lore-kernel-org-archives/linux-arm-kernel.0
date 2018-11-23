From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Nov 2018 14:19:54 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Enable I2C DMA
In-Reply-To: <1540071326-27428-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071326-27428-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdV0RVdYR6SocArG9JujT-GQc-+CjkgUbmtcf-Qy2x2PiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2018 at 11:35 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch enables I2C DMA.
>
> NOTE: I2C7 DMA is not supported by R-Car Gen3 Hardware User's Manual
> Rev.0.80E.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

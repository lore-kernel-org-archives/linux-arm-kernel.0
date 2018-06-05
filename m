From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Jun 2018 15:24:20 +0200
Subject: [PATCH v4 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
In-Reply-To: <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdVPfE=0EynQg1syOiPCMbvtK9ooWo+_hvtY=VEMKMPXHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 1:28 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> Add a special enable method for the second CA7 of the R9A06G032
> as well as the default value for the "cpu-release-addr" property.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

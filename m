From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 15 Dec 2017 09:48:19 +0000
Subject: [PATCH 1/6] ARM: shmobile: defconfig: Enable PWM
In-Reply-To: <CAMuHMdWUaQMgT4J0N+hrByAD12K-oO0+iNyDeVczS3nxr5ia9A@mail.gmail.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513248976-26700-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWUaQMgT4J0N+hrByAD12K-oO0+iNyDeVczS3nxr5ia9A@mail.gmail.com>
Message-ID: <TY1PR06MB0895D343C77D0DB2E9F14680C00B0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> Subject: Re: [PATCH 1/6] ARM: shmobile: defconfig: Enable PWM
>
> Hi Fabrizio,
>
> On Thu, Dec 14, 2017 at 11:56 AM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > RZ/G1 and R-Car platforms have PWM timers. This patch enables PWM support
> > by default.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>
> Thanks for your patch!

Thank you for your feedback.

>
> If I'm not mistaken, there are no current users of this PWM block in the
> current R-Car Gen2 and RZ/G1 DTS files?

PWM support will be needed very soon as we are going to use pwm3 on the iwg20d platform to control the RGB display backlight.
The work to add display support is in progress, I hope it will be ready by next week, would you rather I sent this patch with the series to add display support?

Thanks,
Fab

> If that's correct, I don't think it makes much sense to enable it already.
>
> Simon: what do you think?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe have decided to support Unicef with a donation. For further details click here<https://www.unicef.org/> to find out about the valuable work they do, helping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

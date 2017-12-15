From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Dec 2017 11:01:28 +0100
Subject: [PATCH 1/6] ARM: shmobile: defconfig: Enable PWM
In-Reply-To: <TY1PR06MB0895D343C77D0DB2E9F14680C00B0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513248976-26700-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWUaQMgT4J0N+hrByAD12K-oO0+iNyDeVczS3nxr5ia9A@mail.gmail.com>
 <TY1PR06MB0895D343C77D0DB2E9F14680C00B0@TY1PR06MB0895.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdW81B=oaf2asCtg8BT6tO97PVXmRN4Skbnm35PB0CLHVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Fri, Dec 15, 2017 at 10:48 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>> Subject: Re: [PATCH 1/6] ARM: shmobile: defconfig: Enable PWM
>> On Thu, Dec 14, 2017 at 11:56 AM, Fabrizio Castro
>> <fabrizio.castro@bp.renesas.com> wrote:
>> > RZ/G1 and R-Car platforms have PWM timers. This patch enables PWM support
>> > by default.
>> >
>> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>>
>> Thanks for your patch!
>
> Thank you for your feedback.
>
>>
>> If I'm not mistaken, there are no current users of this PWM block in the
>> current R-Car Gen2 and RZ/G1 DTS files?
>
> PWM support will be needed very soon as we are going to use pwm3 on the iwg20d platform to control the RGB display backlight.

Good to know, thanks!

> The work to add display support is in progress, I hope it will be ready by next week, would you rather I sent this patch with the series to add display support?

That's up to Simon.  But I guess it doesn't matter much, as defconfig updates
are queued in a separate branch anyway.

You may want to send a similar patch for multi_v7_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

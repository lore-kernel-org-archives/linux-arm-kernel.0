From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 4 Apr 2017 12:31:39 +0200
Subject: [PATCH] ARM: dts: koelsch: Correct clock frequency of X2 DU clock
 input
In-Reply-To: <2246751.IOz92zzvZ6@avalon>
References: <1491213319-7668-1-git-send-email-geert+renesas@glider.be>
 <2246751.IOz92zzvZ6@avalon>
Message-ID: <CAMuHMdXqEhjzo5PH3a7JyUsuCBpnDGibGabD5k5oVhZY=FkRow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Apr 4, 2017 at 12:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 03 Apr 2017 11:55:19 Geert Uytterhoeven wrote:
>> The X2 crystal oscillator on the Koelsch development board provides a
>> 74.25 MHz clock, not a 148.5 MHz clock.
>>
>> Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel
>> clocks to DT") Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Confirmed by schematics, user manual, and physical inspection of 2
>> Koelsch instances (my scope has not enough bandwidth to measure the
>> actual frequency).
>
> Stupid question, have you tested the corresponding (HDMI) DU output ? If so,

No I haven't.

Niklas, can you please fire up your display? Thanks!

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

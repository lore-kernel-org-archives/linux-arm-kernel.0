From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 11:42:06 +0200
Subject: [PATCH 1/7] ARM: shmobile: r8a73a4 dtsi: Add missing
 "gpio-ranges" to gpio node
In-Reply-To: <CAMuHMdX4=C6DsbsaphndXQuPm8WFqv08kwq+cdQRJJQtDph1cg@mail.gmail.com>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-2-git-send-email-geert+renesas@glider.be>
 <32630741.rNENluEsDE@avalon>
 <CAMuHMdX4=C6DsbsaphndXQuPm8WFqv08kwq+cdQRJJQtDph1cg@mail.gmail.com>
Message-ID: <CACRpkdbB6mLZAxpvPq8X5cWVLYD05ruF2XbwZSYn16Kj8tXvdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 2:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Jun 30, 2015 at 11:49 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

>>> To fix this, add a "gpio-ranges" property to the gpio device node, so
>>> the ranges are added by of_gpiochip_add_pin_range(), which is called by
>>> of_gpiochip_add() before the call to of_gpiochip_scan_hogs().
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This looks sane to me, even though referencing the same DT node seems a bit
>> dodgy. I'll let Linus comment on that, but for the implementation itself,
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Thank you!
>
> Any wise words from Linus?

I don't know if I'm wise but I'm OK with this:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

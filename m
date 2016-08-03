From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 3 Aug 2016 17:47:07 +0200
Subject: Extcon build failure in next
In-Reply-To: <3746939.q8kt0ym6m3@wuerfel>
References: <20160630053705.GM28140@atomide.com>
 <20160630054112.GN28140@atomide.com> <3746939.q8kt0ym6m3@wuerfel>
Message-ID: <CAMuHMdW-3oLvirOEiFhXU=0JXt9K4ki52C16aX+8HB_9gPSxCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 1:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, June 29, 2016 10:41:13 PM CEST Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [160629 22:41]:
>> Also I'm seeing:
>>
>> drivers/extcon/extcon.c: In function 'extcon_register_notifier':
>> drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    if (idx >= 0) {
>>          ^
>
> I don't see this one. Which compiler version do you use?

Also seen with m68k-linux-gnu-gcc-4.1 in current mainline (fix claimed
to be applied).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

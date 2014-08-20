From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Aug 2014 21:55:33 +0200
Subject: [PATCH v3] arm/smp: Absorb boot_secondary()
In-Reply-To: <201408202130.28389.arnd@arndb.de>
References: <1404918119-3676-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXp0ruZjjJLXmWyCdfAXs9_9xFHDcmJ08M9_SbZqqq04g@mail.gmail.com>
 <201408202130.28389.arnd@arndb.de>
Message-ID: <CAMuHMdVp3xeJ2nDYJ00tLc7HuZ5v+jC-T8omWV5+G_3C8XoyoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Aug 20, 2014 at 9:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 20 August 2014, Geert Uytterhoeven wrote:
>>
>> Ping?
>>
>> On Wed, Jul 9, 2014 at 5:01 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>> > After becoming a mandatory function, boot_secondary() is no longer used
>> > outside arch/arm/kernel/smp.c. Hence remove its public prototype, and,
>> > as suggested by Arnd, let it be absorbed by its single caller.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I think you should add the patch to Russell's patch tracking system
> at http://www.arm.linux.org.uk/developer/patches to get it applied.

<surprised>
Thanks for the info!
</surprised>

Has anyone already written a "git-send-email"-compatible script to
submit patches there?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

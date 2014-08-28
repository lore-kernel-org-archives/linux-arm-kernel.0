From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Aug 2014 15:06:31 +0200
Subject: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in
 multiplatform defconfig
In-Reply-To: <3285079.8x1UeyRQTp@wuerfel>
References: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
 <3285079.8x1UeyRQTp@wuerfel>
Message-ID: <CAMuHMdVQLny1u7SxNvN+jNHSGNfFUPL=fvx8oDgO1EkhZBp8pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Aug 28, 2014 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 August 2014 14:40:22 Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>
> No objections to the patch, but I wonder if you could send another
> patch to enable all the machines working in ARCH_SHMOBILE_MULTI
> as part of multi_v7_defconfig as well.

Sure. I actually have such a patch lying around :-)

I've just added armadillo support there, too, but it hangs during boot
on Armadillo. May be that the image is just too big for the Hermit boot
loader.
It does work on Koelsch. Haven't tried it yet on BeagleBone Black, though.

Do you want it? Or do you want the version without armadillo support?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Feb 2015 19:52:08 +0100
Subject: imx_v6_v7_defconfig needs lzop
In-Reply-To: <20150212175836.52351ae2@canb.auug.org.au>
References: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
 <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
 <CAMuHMdXJCh32e-+7rqNzCdbYX4AH3qfBQ3uZ_t9kC_8+1P1jJQ@mail.gmail.com>
 <20150205105951.GU10842@pengutronix.de>
 <CAMuHMdU_gBiqVouvHaVh+kC=BcdXw5waE6A4phn_MrjkLTu7Ow@mail.gmail.com>
 <20150212175836.52351ae2@canb.auug.org.au>
Message-ID: <CAMuHMdVxiYJc8_9X+KJLdhvu+-vZSC5ZOt43MVxaBibX97y4gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Feb 12, 2015 at 7:58 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >> >> /bin/sh: 1: lzop: not found
>> >> >> cat: write error: Broken pipe
>> >> >> make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1
>> >> >
>> >> > Isn't this error happening due to the lack of 'lzop' package installed
>> >> > on the host machine?
>> >>
>> >> Indeed.
>> > I guess you don't want to ask for help or report a build breakage, but
>> > question if it's sensible to let a defconfig depend on a host tool that
>> > isn't commonly installed, right?
>>
>> Right.
>>
>> The maintainers of the host machines were in the To-header, in the hope they
>> would install the missing tool.
>
> We have now done that.

Thanks, the imx_v6_v7_defconfig build succeeds now.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

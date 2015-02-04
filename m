From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Feb 2015 15:41:45 +0100
Subject: imx_v6_v7_defconfig needs lzop
In-Reply-To: <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
References: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
 <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
Message-ID: <CAMuHMdXJCh32e-+7rqNzCdbYX4AH3qfBQ3uZ_t9kC_8+1P1jJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 3:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Feb 4, 2015 at 12:21 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> http://kisskb.ellerman.id.au/kisskb/buildresult/12358024/
>>
>> /bin/sh: 1: lzop: not found
>> cat: write error: Broken pipe
>> make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1
>
> Isn't this error happening due to the lack of 'lzop' package installed
> on the host machine?

Indeed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 24 May 2016 09:37:04 +0200
Subject: [PATCH v2 11/23] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <20160524003356.GB2477@verge.net.au>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
 <1463728214-13838-12-git-send-email-geert+renesas@glider.be>
 <e0a1fbc1-ac95-2c79-65ed-d0328679bb8a@cogentembedded.com>
 <CAMuHMdXPhMToHhZggdKo=i65nS_mQT1o44YBd_Lz-B2Td3Jm9Q@mail.gmail.com>
 <20160524001309.GA2477@verge.net.au>
 <20160524003356.GB2477@verge.net.au>
Message-ID: <CAMuHMdW8a3jOibXmMxv34RF+cZ7aE5x_fRzAQW4qVb_RB=6sCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 24, 2016 at 2:33 AM, Simon Horman <horms@verge.net.au> wrote:
>> > >> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
>> > >> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts

> I have queued this up with the above hunk changed to the following.
> Please check the resulting patch and let me know if I've messed things up
> somehow.
>
> @@ -127,7 +127,7 @@
>                 };
>         };
>
> -       i2c2: i2c at 2 {
> +       i2c2: i2c-2 {

Thanks, looks fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

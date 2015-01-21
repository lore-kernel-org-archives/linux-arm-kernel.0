From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Jan 2015 11:47:15 +0100
Subject: [PATCH 00/13] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support
In-Reply-To: <87twzkn1rd.wl%kuninori.morimoto.gx@renesas.com>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <87twzkn1rd.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CAMuHMdWoi1TDq-XQO6-EjVzQPyYyeG4e0U+chseQ9MXuO3Lhgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus, Morimoto-san,

On Wed, Jan 21, 2015 at 6:25 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support
>>
>> [PATCH 01/13] ARM: shmobile: mackerel: Remove ZBOOT code
>> [PATCH 02/13] ARM: shmobile: mackerel: Remove Legacy C board code
>> [PATCH 03/13] ARM: shmobile: mackerel dts: Remove Legacy DTS file
>> [PATCH 04/13] ARM: shmobile: mackerel: Remove DT binding documentation
>> [PATCH 05/13] ARM: shmobile: mackerel: Remove mach-type entry
>> [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
>> [PATCH 07/13] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
>> [PATCH 08/13] ARM: shmobile: sh7372: Remove Legacy C SoC code
>> [PATCH 09/13] ARM: shmobile: sh7372: Remove DT binding documentation
>> [PATCH 10/13] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
>> [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and docs
>> [PATCH 12/13] pinctrl: sh-pfc: sh7372: Remove PFC support
>> [PATCH 13/13] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
>
> We spent much time for these.
> Good-bye sh7372...  Good-bye mackerel...

Amen...

Still to be removed: a few compatible entries in code and DT binding
documentation; "git grep -i sh7372" is your friend ;-)

It seems arch/sh still supports Linux running on the SH core in sh7372?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

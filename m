From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Apr 2017 09:04:48 +0200
Subject: [PATCH 2/8] [RFC] arm64: dts: renesas: Add R-Car H3 SiP (4 x 1
 GiB) support
In-Reply-To: <20170421054201.GR28868@bigcity.dyn.berto.se>
References: <1492593351-13835-1-git-send-email-geert+renesas@glider.be>
 <1492593351-13835-3-git-send-email-geert+renesas@glider.be>
 <20170421054201.GR28868@bigcity.dyn.berto.se>
Message-ID: <CAMuHMdUbhONx9=mf=EG_soLEAkrb-jsZD_pAkkovc5wMDdv8hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Fri, Apr 21, 2017 at 7:42 AM, Niklas S?derlund
<niklas.soderlund@ragnatech.se> wrote:
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/r8j7795-4x1g.dtsi
>> @@ -0,0 +1,36 @@
>> +/*
>> + * Device Tree Source for the r8j7795 SiP with 4 channels of 1 GiB RAM
>> + *
>> + * Copyright (C) 2015 Renesas Electronics Corp.
>
> 2017 right? If so same comment for patches 3 and 4.

As I just moved statements from an existing file, I retained the original
copyright information.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

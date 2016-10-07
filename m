From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 7 Oct 2016 09:50:51 +0200
Subject: [PATCH v3 04/11] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <20161007030932.GH13721@verge.net.au>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
 <20161007030932.GH13721@verge.net.au>
Message-ID: <CAMuHMdXvja__VsjccDBuvBQqoKzqg_YrckQORZvMgVsJSd=KgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 7, 2016 at 5:09 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 06, 2016 at 12:38:18AM +0300, Sergei Shtylyov wrote:
>> The  initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
>> CPG, and the required clock descriptions.
>>
>> Based on the original (and large) patch by Dmitry Shifrin
>> <dmitry.shifrin@cogentembedded.com>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> I notice that this patch enables two CPUs. Have you tested SMP and:
> - CPU hotplug
> - Suspend to RAM

The APMU node and the CPU enable-method "renesas,apmu" are missing
to have working SMP.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

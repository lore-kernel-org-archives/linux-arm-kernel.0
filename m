From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Sep 2017 11:13:25 +0200
Subject: [PATCH] arm64: dts: draak: Add serial console pins
In-Reply-To: <20170830064402.GB10398@verge.net.au>
References: <1503912370-20180-1-git-send-email-geert+renesas@glider.be>
 <20170830064402.GB10398@verge.net.au>
Message-ID: <CAMuHMdVCUcy48qDvDSDZ9MAgCLiSUd4zgFD2iu5eWkTVinN1Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 8:44 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 28, 2017 at 11:26:10AM +0200, Geert Uytterhoeven wrote:
>> Add pin control for SCIF2.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> To be applied after v4.14-rc1, when commit 794a6711764658a1 ("pinctrl:
>> sh-pfc: Initial R8A77995 PFC support") has hit mainline.
>>
>> Else the serial console will fail, reporting (on earlycon):
>>
>>     sh-sci e6e88000.serial: could not find pctldev for node /soc/pin-controller at e6060000/scif2, deferring probe
>
> Thanks, please ping me once that has happened.
> In the meantime I have marked this patch as deferred.

Ping...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

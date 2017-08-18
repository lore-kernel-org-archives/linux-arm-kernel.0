From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Aug 2017 10:07:26 +0200
Subject: [PATCH] arm64: dts: r8a7795-es1: Drop extra zero from usb unit
 address
In-Reply-To: <20170818080215.GG9175@verge.net.au>
References: <1502969354-14968-1-git-send-email-geert+renesas@glider.be>
 <20170818080215.GG9175@verge.net.au>
Message-ID: <CAMuHMdVrtWBYEgS5Wapn_oyg2izuOkGzSdX-hXmMn8C2iJaJXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Aug 18, 2017 at 10:02 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Aug 17, 2017 at 01:29:14PM +0200, Geert Uytterhoeven wrote:
>> With W=1:
>>
>>     arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/usb at ee0400000 simple-bus unit address format error, expected "ee040000"
>>     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/usb at ee0400000 simple-bus unit address format error, expected "ee040000"
>>
>> Fixes: 291e0c4994d0813f ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
>> Fixes: 171f2ef82284f61b ("arm64: dts: r8a7795: Add USB3.0 host device nodes")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> The second fixes tag is for the original r8a7795.dtsi, before
>> r8a7795-es1.dtsi was split off.
>
> Do you want this treated as a fix for v4.13 or v4.14, or a regular patch
> for v4.15? It looks like the problem has been present in some form since
> v4.12.

It's not a critical fix (no impact at all?), so v4.15 is fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

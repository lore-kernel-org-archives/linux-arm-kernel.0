From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Jan 2017 10:09:48 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.11
In-Reply-To: <20170110075403.GA25239@verge.net.au>
References: <cover.1483700694.git.horms+renesas@verge.net.au>
 <20170110031532.GF22261@localhost> <20170110075403.GA25239@verge.net.au>
Message-ID: <CAMuHMdXMsufGo_4LVZ6Z8mOpheUDWRmWq2kpf_XDd4hqGrEnBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 8:54 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jan 09, 2017 at 07:15:32PM -0800, Olof Johansson wrote:
>> On Fri, Jan 06, 2017 at 12:17:56PM +0100, Simon Horman wrote:
>> > ----------------------------------------------------------------
>> > Chris Paterson (3):
>> >       arm64: dts: r8a7796: Add CAN external clock support
>> >       arm64: dts: r8a7796: Add CAN support
>> >       arm64: dts: r8a7796: Add CAN FD support
>> >
>> > Geert Uytterhoeven (2):
>> >       arm64: dts: r8a7796: Add all MSIOF nodes
>> >       arm64: renesas: r8a7796/salvator-x: Add board part number to DT bindings
>>
>> Nit: When you look at the shortlog, these with different/random format
>> stand out. Feel free to fix them before sending next time.
>
> Sure, sorry for letting that slip through.

Note that the last one stands out because it's not a DTS update, but a DT
binding update, and thus follows a different convention ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

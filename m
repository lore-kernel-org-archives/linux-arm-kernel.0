From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 09:23:33 +0100
Subject: [PATCH] arm64: defconfig: enable R8A77965 SoC
In-Reply-To: <20180223150023.f2pf3afpcckbskme@verge.net.au>
References: <20180223085115.13782-1-horms+renesas@verge.net.au>
 <CAMuHMdVsOzXz+pU_7bDaQgs371zozy6Za8eDDiauV8qu03ckmw@mail.gmail.com>
 <20180223150023.f2pf3afpcckbskme@verge.net.au>
Message-ID: <CAMuHMdXg1qYsS8H1EQ+rs9r2uibtraYv9jhgrzO=mBpSx5D0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Feb 23, 2018 at 4:00 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Feb 23, 2018 at 10:19:45AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Feb 23, 2018 at 9:51 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > Enable the Renesas R-Car M3-W (R8A77965) SoC in the ARM64 defconfig.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I have applied this to the topic/renesas-defconfig branch which is included
> in the devel branch and tags of the Renesas tree as a convenience to
> developers.  The branch is not, however, included in the next branch or
> tags nor is it targeted at upstream.

Looks like it accidentally ended up in your next branch.

Merge report from sfr:

Merging renesas/next (60d04a4b6d41 Merge branch
'topic/renesas-defconfig' into next)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

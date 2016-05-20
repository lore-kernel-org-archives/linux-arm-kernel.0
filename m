From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 20 May 2016 08:49:35 +0200
Subject: [PATCH/RFC 2/3] arm64: dts: salvator-x: add Salvator-X board on
 R8A7796 SoC
In-Reply-To: <20160520041445.GC25184@verge.net.au>
References: <1463629845-7115-1-git-send-email-horms+renesas@verge.net.au>
 <1463629845-7115-3-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVTMvDsmO1g=FNwpkvx_56guHk_V6Katj8e3qOdyQsjeQ@mail.gmail.com>
 <20160520041445.GC25184@verge.net.au>
Message-ID: <CAMuHMdXTrLiu5e1Ki6UXmJ1WJ1fWLFYOrmjGNfmRM9Goeha-vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, May 20, 2016 at 6:14 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 19, 2016 at 06:58:11PM +0200, Geert Uytterhoeven wrote:
>> On Thu, May 19, 2016 at 5:50 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
>> > @@ -0,0 +1,45 @@
>>
>> > +       chosen {
>> > +               bootargs = "ignore_loglevel";
>>
>> Perhaps you want this to be consistent with the other Renesas boards?
>>
>> git grep bootargs -- $(git grep -l renesas, -- arch/arm*/*dts)
>
> I omitted "rw root=/dev/nfs ip=dhcp" which I believe should be added
> when the board gets network and thus NFS-root support.

Fair enough.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 09:23:44 +0100
Subject: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
In-Reply-To: <20151215051243.GA29362@verge.net.au>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
 <20151211230751.GD6496@verge.net.au>
 <20151215051243.GA29362@verge.net.au>
Message-ID: <CAMuHMdXsTNgj_diedKG8MPGZgQKzJhSPN5+fB+qe2ib3FX2eAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Dec 15, 2015 at 6:12 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Dec 12, 2015 at 08:07:51AM +0900, Simon Horman wrote:
>> On Fri, Dec 04, 2015 at 02:38:52PM +0100, Dirk Behme wrote:
>> > From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> >
>> > Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.
>> >
>> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> > Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
>>
>> Thanks, I have queued this up for v4.5.
>
> I meant to test this earlier but somehow it slopped my mind.
>
> With this patch applied I still only see one CPU brought up
> whereas I was expecting 4. Are more patches needed in order to
> get more CPUs operating?
>
> I am using renesas-devel-20151214-v4.4-rc5 + the cpg-mmsr driver (v6).
> I built the kernel using the defconfig.

I can confirm I saw 4 CPUs online as soon as I had merged renesas-devel
containing the above change into my tree (which was based on
renesas-drivers-2015-12-08-v4.4-rc4 at that time).

I was surprised to see it was that simple to enable the 3 other cores ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

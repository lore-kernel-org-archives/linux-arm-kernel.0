From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Apr 2015 11:30:22 +0200
Subject: [GIT PULL] ARM perf updates for 4.1
In-Reply-To: <20150413091011.GA1582@arm.com>
References: <20150327172246.GN1562@arm.com>
 <CAMuHMdUvjqYSSTwFcyhn=ChCJWZsqvL1CAVWRgnid0=giD56Ag@mail.gmail.com>
 <20150413091011.GA1582@arm.com>
Message-ID: <CAMuHMdUPpAnJz7Pv=aTv+ZhCkjDPLkry_gV6=GFMmSCEsXEOSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, Apr 13, 2015 at 11:10 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 07, 2015 at 04:05:40PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Mar 27, 2015 at 6:22 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > Will Deacon (1):
>> >       ARM: pmu: add support for interrupt-affinity property
>>
>> As most DTSes lack this property, we now get scary warnings:
>>
>>         CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]
>
> That's a harmless warning (i.e. perf will `work' as before), but I'd like to
> print something to say that we didn't find the property.
>
>> BTW, shouldn't the DT update go in first, or together with the code update?
>
> It's going via the arm64 tree (I had to choose one of the trees for the
> binding, since they both arm and arm64 use it).

OK. Will start to pull arm64 too into renesas-drivers...

BTW, time to start unifying arm32 and arm64? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
